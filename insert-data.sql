INSERT INTO clients (name, surname, email, phone)
VALUES
  ('Yuliia', 'Kostandi', 'yuliia.kostandi@lll.kpi.ua', '+380631234511'),
  ('Stepan', 'Kostenich', 'stepan.kostenich@lll.kpi.ua', '+380631234512'),
  ('Kyrylo', 'Bohutskyi', 'kyrylo.bohutskyi@lll.kpi.ua', '+380631234501'),
  ('Kateryna', 'Hleba', 'kateryna.hleba@lll.kpi.ua', '+380631234505'),
  ('Ivan', 'Hrytsenko', 'ivan.hrytsenko@lll.kpi.ua', '+380631234506'),
  ('Anton', 'Dobrovolskyi', 'anton.dobrovolskyi@lll.kpi.ua', '+380631234508'),
  ('Maksym', 'Povnych', 'maksym.povnych@lll.kpi.ua', '+380631234522');

INSERT INTO menu_items (name, description, price, category)
VALUES
  ('Big Mac', 'Double beef patties, lettuce, cheese, pickles, onions, and Big Mac sauce in a sesame bun.', 5.99, 'main course'),
  ('McChicken', 'Crispy chicken sandwich with lettuce and mayo.', 4.79, 'main course'),
  ('Fries', 'Golden, crispy potato fries lightly salted.', 2.49, 'side dish'),
  ('Chicken McNuggets', 'Crispy chicken bites served with your choice of sauce.', 3.99, 'appetizer'),
  ('Caesar Salad', 'Romaine lettuce with Caesar dressing, croutons, and parmesan.', 4.59, 'salad'),
  ('Apple Pie', 'Warm, crispy pastry filled with apple and cinnamon.', 1.99, 'dessert'),
  ('McFlurry Oreo', 'Vanilla soft serve mixed with crushed Oreo cookies.', 2.99, 'dessert'),
  ('Coca-Cola', 'Classic Coke served chilled.', 1.79, 'beverage'),
  ('Latte', 'Freshly brewed espresso with steamed milk.', 2.89, 'beverage'),
  ('Tomato Soup', 'Creamy tomato soup served hot.', 3.49, 'soup');

INSERT INTO tables (table_number, capacity, location)
VALUES
  (1, 2, 'Near window'),
  (2, 4, 'By the entrance'),
  (3, 8, 'In the centre'),
  (4, 6, 'Family zone'),
  (5, 2, 'Next to the bar');

INSERT INTO orders (client_id, table_id, status)
VALUES
  (1, 1, 'pending'),
  (2, 2, 'preparing'),
  (3, 3, 'pending'),
  (4, 4, 'ready'),
  (5, 5, 'completed');

INSERT INTO order_items (order_id, item_id, quantity)
VALUES
  (1, 1, 1),
  (1, 3, 1),
  (1, 8, 1),
  (2, 2, 1),
  (2, 5, 1),
  (2, 9, 1),
  (3, 4, 2),
  (3, 7, 1),
  (4, 1, 1),
  (4, 6, 2),
  (5, 9, 1),
  (5, 8, 1);
