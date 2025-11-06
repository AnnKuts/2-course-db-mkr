## Structure

* [`ddl.sql`](/ddl.sql) – contains implementation of task 1: SQL statements for creating database tables, defining relationships between them, and setting up constraints for restaurant database schema
* [`insert_data.sql`](/insert_data.sql) – provides sample data
* [`oltp.sql`](/oltp.sql) – contains implementation of task 2: includes transactional (OLTP) queries
* [`olap.sql`](/olap.sql) – contains implementation of task 3: includes analytical (OLAP) queries

## Tasks

1. Підготовка схеми бази даних:
- Клієнти (ім'я, телефон, email) 
- Столики (номер столика, місткість, розташування)
- Позиції меню (назва, опис, ціна, категорія)
- Замовлення (час замовлення, статус) 
- Позиції замовлення (позиції в кожному замовленні з кількістю)

2. OTLP запити:
- 2 INSERT запити до будь-яких таблиць 
- 2 UPDATE запити до будь-яких таблиць 
- 2 DELETE запити з будь-яких таблиць 
- 2 прості SELECT: підготувати чек для замовлення, знайти всі не зайняті столики (столики, для яких немає незавершених замовлень)

3. OLAP запити:
- Обчислити загальний денний дохід за датами за останній місяць
- Знайти топ-10 найбільш популярних позицій меню
- Обчислити середню вартість замовлення за часом доби (сніданок, обід, вечеря)
- Визначити клієнтів з найбільшими загальними витратами (CTE)