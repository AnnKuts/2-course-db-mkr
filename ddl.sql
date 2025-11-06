DROP TYPE IF EXISTS order_status CASCADE;
DROP TYPE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS menu_items CASCADE;
DROP TABLE IF EXISTS tables CASCADE;
DROP TABLE IF EXISTS clients CASCADE;

-- - Необхідні сутності
-- - Клієнти (ім'я, телефон, email)
-- - Столики (номер столика, місткість, розташування)
-- - Позиції меню (назва, опис, ціна, категорія)
-- - Замовлення (час замовлення, статус)
-- - Позиції замовлення (позиції в кожному замовленні з кількістю)

DO
$$
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'category') THEN
      CREATE TYPE category AS ENUM ('main course', 'side dish', 'dessert', 'beverage', 'appetizer', 'salad', 'soup');
    END IF;
  END
$$;

DO
$$
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'order_status') THEN
      CREATE TYPE order_status AS ENUM ('pending', 'preparing', 'ready', 'completed', 'cancelled');
    END IF;
  END
$$;

CREATE TABLE IF NOT EXISTS clients
(
  client_id serial PRIMARY KEY,
  name      varchar(32) NOT NULL,
  surname   varchar(32) NOT NULL,
  email     varchar(32) NOT NULL UNIQUE,
  phone     varchar(32) NOT NULL UNIQUE,
  is_deleted boolean DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS tables
(
  table_id     serial PRIMARY KEY,
  table_number integer NOT NULL UNIQUE CHECK (table_number > 0),
  capacity     integer NOT NULL CHECK (capacity > 0),
  location     text    NOT NULL,
  is_deleted boolean DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS menu_items
(
  item_id     serial PRIMARY KEY,
  name        varchar(32)    NOT NULL,
  description text,
  price       numeric(10, 2) NOT NULL CHECK (price > 0),
  category    category       NOT NULL,
  is_deleted  boolean DEFAULT false
);


CREATE TABLE IF NOT EXISTS orders
(
  order_id   serial PRIMARY KEY,
  order_date timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status     order_status NOT NULL DEFAULT 'pending',
  client_id  integer      NOT NULL references clients (client_id),
  table_id   integer references tables (table_id),
  is_deleted  boolean DEFAULT false
);


CREATE TABLE IF NOT EXISTS order_items
(
  order_item_id serial PRIMARY KEY,
  quantity      integer NOT NULL CHECK (quantity > 0),
  order_id      integer NOT NULL references orders (order_id) ON DELETE CASCADE,
  item_id       integer NOT NULL references menu_items (item_id)
);