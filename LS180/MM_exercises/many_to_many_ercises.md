# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞
```sql
CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  payment_token CHAR(8) NOT NULL UNIQUE CHECK (payment_token ~ '^[A-Z]+$')
);

CREATE TABLE services(
  id SERIAL PRIMARY KEY,
  descriptions TEXT NOT NULL,
  price DECIMAL(10,2) CHECK (price >= 0.00)
);

INSERT INTO customers("name", payment_token)
  VALUES
    ('Pat Johnson', 'XHGOAHEQ'),
    ('Nancy Monreal', 'JKWQPJKL'),
    ('Lynn Blake', 'KLZXWEEE'),
    ('Chen Ke-Hua', 'KWETYCVX'),
    ('Scott Lakso', 'UUEAPQPS'),
    ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services("descriptions", price)
  VALUES
    ('Unix Hosting',5.95),
    ('DNS,', 4.95),
    ('Whois Registration', 1.95),
    ('High Bandwidth', 15.00),
    ('Business Support', 250.00),
    ('Dedicated Hosting', 50.00),
    ('Bulk Email', 250.00),
    ('One-to-one Training', 999.00);

CREATE TABLE customers_services(
  id SERIAL PRIMARY KEY,
  service_id INT REFERENCES services(id),
  customer_id INT NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  UNIQUE (service_id, customer_id)
);

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

2. Get Customers With Services

```sql
SELECT DISTINCT c.*, STRING_AGG(s.descriptions, ', ') AS services_registed_to
 FROM customers c
  LEFT OUTER JOIN customers_services cs ON cs.customer_id = c.id
  LEFT OUTER JOIN services s ON cs.service_id = s.id
GROUP BY c.id;

```
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

3. Get Customers With No Services

```sql
SELECT c.*, s.*
 FROM customers c
  LEFT OUTER JOIN customers_services cs ON cs.customer_id = c.id
  FULL OUTER JOIN services s ON cs.service_id = s.id
WHERE cs.service_id IS NULL;
```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

4. Get Services With No Customers

Using RIGHT OUTER JOIN, write a query to display a list of all services that are not currently in use. Your output should look like this:

 description
-------------
 One-to-one Training
(1 row)


```sql
--LS solution

SELECT s.description
  FROM customers_services cs
    RIGHT OUTER JOIN services s ON s.id = cs.service_id
WHERE service_id IS NULL;
```



```sql
-- Alternative
SELECT s.description
  FROM services s
    LEFT OUTER JOIN customers_services cs ON cs.service_id = s.id
    LEFT OUTER JOIN customers c ON cs.customer_id = c.id
WHERE cs.customer_id IS NULL;
```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

5. Services for each Customer

```sql

SELECT DISTINCT c.*, STRING_AGG(s.description, ', ') AS services_registed_to
 FROM customers c
  LEFT OUTER JOIN customers_services cs ON cs.customer_id = c.id
  LEFT OUTER JOIN services s ON cs.service_id = s.id
GROUP BY c.id
ORDER BY c.id;

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

6. Services With At Least 3 Customers

Write a query that displays the description for every service that is subscribed to by at least 3 customers. Include the customer count for each description in the report. The report should look like this:

description  | count
--------------+-------
 DNS          |     3
 Unix Hosting |     5
(2 rows)


```sql

SELECT s.description, COUNT(cs.service_id)
  FROM services s
    INNER JOIN customers_services cs ON cs.service_id = s.id
GROUP BY description
HAVING COUNT(cs.customer_id) >= 3;

```


# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

7. Total Gross Income

Assuming that everybody in our database has a bill coming due, and that all of them will pay on time, write a query to compute the total gross income we expect to receive.

Answer:

  gross
 --------
 678.50
(1 row)

```sql
SELECT SUM(s.price)
  FROM services s
    INNER JOIN customers_services cs ON cs.service_id = s.id;
```

This query does not require a second table because we can get all the data we need from `services`, which contains all `price` columns and `customers_services`, which contains all instances of customer and service relationships. From this we can get the sum of services who have a connection to a customer since each `service_id` is tied to a `customer_id` in the `customers_services` table.

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

8. Add New Customer

A new customer, 'John Doe', has signed up with our company. His payment token is 'EYODHLCN'. Initially, he has signed up for UNIX hosting, DNS, and Whois Registration. Create any SQL statement(s) needed to add this record to the database.

```sql
INSERT INTO customers ("name", payment_token)
  VALUES
    ('John Doe', 'EYODHLCN');

INSERT INTO customers_services (customer_id, service_id)
  VALUES
    (7, 1),
    (7, 2),
    (7, 3);


```
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞
9. Hypothetically

```sql

SELECT SUM(s.price)
  FROM services s
    INNER JOIN customers_services cs ON cs.service_id = s.id
WHERE s.price > 100;

-- 

SELECT SUM(price)
  FROM customers
    CROSS JOIN services
WHERE price > 100;
```

```sql
-- Using subqueries
SELECT
  (SELECT COUNT(*) FROM customers) *
  (SELECT SUM(price) FROM services WHERE price > 100);
```

ALTER TABLE customers_services
ADD FOREIGN_KEY (service_id) REFERENCES services(id) ON DELETE CASCADE;
DROP CONSTRAINT customers_services_service_id_fkey;


#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

```sql
SELECT f.title, d.name, f.id AS film_id, f.director_id FROM filsm AS f INNER JOIN directors AS d ON f.director_id = d.id;
```


```sql
CREATE TABLE ab (
    a INTEGER,
    b INTEGER
);

INSERT INTO ab (a, b) VALUES
(1, 2),
(2, 2),
(3, 2);


CREATE TABLE bc (
    b INTEGER,
    c INTEGER
);


INSERT INTO bc (b, c) VALUES
(2, 10),
(2, 9),
(2, 8);
```

```sql

SELECT ab.a, ab.b, bc.c
FROM ab
INNER JOIN bc ON ab.b = bc.b;

SELECT ab.a, ab.b, bc.c
FROM ab
LEFT OUTER JOIN bc ON ab.b = bc.b;

SELECT ab.a, ab.b, bc.c
FROM ab
RIGHT OUTER JOIN bc ON ab.b = bc.b;



``````sql

INSERT INTO books_authors (book_id, author_id) VALUES
  (1, 2),
  (6, 2),
  (9, 2);
INSERT INTO books_authors (book_id, author_id) VALUES
  (2, 1);
INSERT INTO books_authors (book_id, author_id) VALUES
  (3, 5),
  (13, 5);
INSERT INTO books_authors (book_id, author_id) VALUES
  (4, 4);  
INSERT INTO books_authors (book_id, author_id) VALUES
  (7, 3),  
  (7, 9);  

INSERT INTO books_authors (book_id, author_id) VALUES
  (8, 7), 
  (10, 7),
  (11, 7);

INSERT INTO books_authors (book_id, author_id) VALUES
  (12, 6);
```

```sql
SELECT
  a.name AS author,
  COUNT(b.id) AS number_of_books,
  ROUND(AVG(b.page_count)) AS average_page_count
FROM authors a
LEFT JOIN books_authors ba ON a.id = ba.author_id
LEFT JOIN books b ON ba.book_id = b.id
WHERE id = 4
GROUP BY a.name
ORDER BY number_of_books DESC, author;


```

SELECT authors.name, books.title FROM authors
LEFT OUTER JOIN books_authors ON books_authors.author_id = authors.id
LEFT OUTER JOIN books ON books_authors.book_id = books.id
WHERE books.title IS NULL;


SELECT authors.name, books.title FROM authors
RIGHT OUTER JOIN books_authors ON books_authors.author_id = authors.id
RIGHT OUTER JOIN books ON books_authors.book_id = books.id
WHERE authors.name IS NULL;


```sql
SELECT authors.name, COUNT(books.title), TRUNC(AVG(page_count), 0) AS "Average Page Count" 
FROM books
RIGHT OUTER JOIN books_authors ON books_authors.book_id = books.id
RIGHT OUTER JOIN authors ON books_authors.author_id = authors.id
GROUP BY authors.name
ORDER BY count DESC, "Average Page Count" DESC;
```


#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

```sql
SELECT authors.name, COUNT(books.title), TRUNC(AVG(page_count), 0) AS "Average Page Count" 
FROM books
RIGHT OUTER JOIN books_authors ON books_authors.book_id = books.id
RIGHT OUTER JOIN authors ON books_authors.author_id = authors.id
GROUP BY authors.name
ORDER BY count DESC;
```
#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞



```sql
INSERT INTO books(title, year_published, page_count)
VALUES ('so many books so little time', 2028, 150);

```
Because were combining both tables and then retreiving values from them with the `SELECT` clause `ab.a, ab.b, bc.c`

```sql
CREATE TABLE test_a(
  id SERIAL PRIMARY KEY,
  name TEXT
);

INSERT INTO test_b (name)
VALUES ('suzzy'), ('sally'), ('diana');
b
CREATE TABLE test_b(
  id SERIAL PRIMARY KEY,
  name TEXT
);


Because were joining rows based on the `join condition`, which states that the column `b` in table `ab` should correspond with `b` in table `bc`. In all three `JOIN` statements, `2` in table `ab` matches `2` in table `bc`, each returning 3 rows.

2 = 2 => 3
2 = 2 => 3
2 = 2 => 3 = 9




 Because of this a corresponding row is matched for each column in the `SELECT` clause:

 CREATE TABLE vehicles_manufacturers(
  vehicle_id INT,
  manufacturer_id INT,
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(id),
  FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id)
 );


```
`LEFT OUTER JOIN` is used when we want exact matches without pairing columns with `NULL`. It basically returns rows where there is a match in both tables based on the join condition.

`LEFT OUTER JOIN` is used when we want to return all rows from the left-hand table, even if there's no matching row in the right-hand table. Non matching rows are displayed as parially empty, with `NULL` values in the column from the right side of the table.
  Owner     Pet
-------+-----
 Layla |
-------+-----

A `RIGHT OUTER JOIN` is similar to a left, but reverses the logic returning rows starting from the right-hand table, even if there's no matching left-hand table. Non matched column are also `NULL`.
 Owner   Pet
------+------
      |  Dog
------+------

An `INNER JOIN` only returns matching rows; meaning that a column on either the right or left hand side of the table must contain a value for a row to appear in the result.
  Owner     Pet
---------+------
  Layla  |  Dog
----+------

A `FULL JOIN` or `FULL OUTER JOIN` contains all rows from both the left and right tables. It essentially combines the logic of a `LEFT JOIN` and `RIGHT JOIN`, combining the rows of the two tables where the *join condition* is met. 

For any rows on either side of the join where the join condition is not met, the columns for the other table have `NULL` values for that row.

 Owner |    Pet
-------+-------
 Layla |  Dog
 Layla |    
       | Cat



A `CROSS JOIN` is different in that it doesn't require a *join condition* because it combines all possible rows crossed from a left and right table.

```


`LEFT OUTER JOIN` is used when we want exact matches without pairing columns with `NULL`. It basically returns rows where there is a match in both tables based on the join condition.

`LEFT OUTER JOIN` is used when we want to return all rows from the left-hand table, even if there's no matching row in the right-hand table. Non matching rows are displayed as parially empty, with `NULL` values in the column from the right side of the table.
```
  Owner     Pet
-------+-----
 Layla |
-------+-----
```
A `RIGHT OUTER JOIN` is similar to a left, but reverses the logic returning rows starting from the right-hand table, even if there's no matching left-hand table. Non matched column are also `NULL`.
```
 Owner   Pet
------+------
      |  Dog
------+------
```
An `INNER JOIN` only returns matching rows; meaning that a column on either the right or left hand side of the table must contain a value for a row to appear in the result.
  Owner     Pet
```
---------+------
  Layla  |  Dog
----+------
```
A `FULL JOIN` or `FULL OUTER JOIN` contains all rows from both the left and right tables. It essentially combines the logic of a `LEFT JOIN` and `RIGHT JOIN`, combining the rows of the two tables where the *join condition* is met. 

For any rows on either side of the join where the join condition is not met, the columns for the other table have `NULL` values for that row.

```
 Owner |    Pet
-------+-------
 Layla |  Dog
 Layla |    
       | Cat
```

A `CROSS JOIN` is different in that it doesn't require a *join condition* because it combines all possible rows crossed from a left and right table.
