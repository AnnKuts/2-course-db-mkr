--Обчислити загальний денний дохід за датами за останній місяць
SELECT
  DATE(order_date) AS order_day,
  SUM(order_items.quantity * menu_items.price) AS daily_revenue
FROM orders
       JOIN order_items ON orders.order_id = order_items.order_id
       JOIN menu_items ON order_items.item_id = menu_items.item_id
WHERE orders.is_deleted = FALSE
  AND orders.order_date >= NOW() - INTERVAL '1 month'
  AND orders.status = 'completed'
GROUP BY DATE(order_date)
ORDER BY order_day;

--Знайти топ-10 найбільш популярних позицій меню
SELECT
  menu_items.name AS item_name,
  SUM(order_items.quantity) AS total_sold
FROM order_items
       JOIN menu_items ON order_items.item_id = menu_items.item_id
       JOIN orders ON order_items.order_id = orders.order_id
WHERE menu_items.is_deleted = FALSE
  AND orders.is_deleted = FALSE
  AND orders.status = 'completed'
GROUP BY menu_items.name
ORDER BY total_sold DESC
LIMIT 10;

--Обчислити середню вартість замовлення за часом доби (сніданок, обід, вечеря)
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM orders.order_date) BETWEEN 6 AND 11 THEN 'breakfast'
    WHEN EXTRACT(HOUR FROM orders.order_date) BETWEEN 12 AND 17 THEN 'lunch'
    WHEN EXTRACT(HOUR FROM orders.order_date) BETWEEN 18 AND 23 THEN 'dinner'
    ELSE 'not working hours'
    END AS time_of_day,
  ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
  SELECT
    orders.order_id,
    SUM(order_items.quantity * menu_items.price) AS order_total
  FROM orders
         JOIN order_items ON orders.order_id = order_items.order_id
         JOIN menu_items ON order_items.item_id = menu_items.item_id
  WHERE orders.is_deleted = FALSE
    AND menu_items.is_deleted = FALSE
    AND orders.status = 'completed'
  GROUP BY orders.order_id
) AS order_summary
       JOIN orders ON order_summary.order_id = orders.order_id
GROUP BY time_of_day
ORDER BY time_of_day;

---Визначити клієнтів з найбільшими загальними витратами (CTE)
WITH customer_spending AS (
  SELECT
    clients.client_id,
    clients.name,
    clients.surname,
    SUM(order_items.quantity * menu_items.price) AS total_spent
  FROM clients
         JOIN orders ON clients.client_id = orders.client_id
         JOIN order_items ON orders.order_id = order_items.order_id
         JOIN menu_items ON order_items.item_id = menu_items.item_id
  WHERE clients.is_deleted = FALSE
    AND orders.is_deleted = FALSE
    AND menu_items.is_deleted = FALSE
    AND orders.status = 'completed'
  GROUP BY clients.client_id, clients.name, clients.surname
)
SELECT
  client_id,
  name,
  surname,
  ROUND(total_spent, 2) AS total_spent
FROM customer_spending
ORDER BY total_spent DESC
LIMIT 10;