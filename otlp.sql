SELECT * from clients;
SELECT * from menu_items;
SELECT * from tables;
SELECT * from orders;
SELECT * from order_items;

INSERT INTO clients (name, surname, email, phone)
VALUES ('Anna', 'Kuts', 'kuts.anna@lll.kpi.ua', '+380730909009'),
  ('Angelina', 'Jolie', 'angelina.jolie@gmail.com', '+14155552368'),
  ('Volodymyr', 'Putin', 'volodymyr.putin@mail.ru', '+79010101001');

INSERT INTO tables (table_number, capacity, location)
VALUES (6, 2, 'VIP zone'),
  (7, 4, 'Terrace'),
  (8, 6, 'Private room');

INSERT INTO orders (client_id, table_id, status)
VALUES (8, 6, 'pending'),
  (9, 8, 'completed');

INSERT INTO order_items (order_id, item_id, quantity)
VALUES
  (6, 1, 1),
  (6, 3, 1),
  (6, 8, 1),
  (7, 1, 2),
  (7, 4, 10),
  (7, 7, 1),
  (7, 8, 2);

SELECT * from clients;
SELECT * from menu_items;
SELECT * from tables;
SELECT * from orders;
SELECT * from order_items;

--2 UPDATE запити до будь-яких таблиць

UPDATE orders
SET status = 'ready'
WHERE order_id = 6;

SELECT status, order_date, is_deleted
FROM orders
WHERE order_id = 6;

UPDATE menu_items
SET price = price * 0.8
WHERE category = 'beverage';

SELECT name, category, price
FROM menu_items
WHERE category = 'beverage';

--2 DELETE запити з будь-яких таблиць

--soft delete
UPDATE menu_items
SET is_deleted = TRUE
WHERE name = 'Tomato Soup';

SELECT name, category, is_deleted
FROM menu_items
WHERE name = 'Tomato Soup';

UPDATE orders
SET is_deleted = TRUE
WHERE order_date < NOW() - INTERVAL '3 months';

SELECT status, order_date, is_deleted
FROM orders
WHERE order_date < NOW() - INTERVAL '3 months';

--hard delete
DELETE FROM clients
WHERE name = 'Volodymyr' AND surname = 'Putin';

SELECT name, surname, email
FROM clients
WHERE name = 'Volodymyr' AND surname = 'Putin';
--volodymyr putin is h**** and didn't order anything(thanks god)

DELETE FROM menu_items
WHERE name = 'Tomato Soup' AND is_deleted = TRUE;

SELECT name, category
FROM menu_items
WHERE name = 'Tomato Soup';
--no one ordered tomato soup so it doesn't cause a problem

--2 прості SELECT:

--receipt for Angelina Jolie
SELECT orders.order_id,
  clients.name                                                                     AS client_name,
  clients.surname                                                                  AS client_surname,
  menu_items.name                                                                  AS item_name,
  menu_items.description                                                           AS item_description,
  order_items.quantity                                                             AS quantity,
  menu_items.price                                                                 AS price_per_item,
  (order_items.quantity * menu_items.price)                                        AS total_price_per_item,
    SUM(order_items.quantity * menu_items.price) OVER (PARTITION BY orders.order_id) AS total_price
FROM orders
       JOIN clients ON orders.client_id = clients.client_id
       JOIN order_items ON orders.order_id = order_items.order_id
       JOIN menu_items ON order_items.item_id = menu_items.item_id
WHERE orders.order_id = 9;

--free tables
SELECT tables.table_id, tables.table_number, tables.capacity, tables.location
FROM tables
WHERE tables.table_id NOT IN (SELECT DISTINCT orders.table_id
                              FROM orders
                              WHERE orders.status IN ('pending', 'preparing', 'ready')
                                AND orders.is_deleted = FALSE
                                AND orders.table_id IS NOT NULL);