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
---

2. Get Customers With Services

```sql
SELECT DISTINCT c.*, STRING_AGG(s.descriptions, ', ') AS services_registed_to
 FROM customers c
  LEFT OUTER JOIN customers_services cs ON cs.customer_id = c.id
  LEFT OUTER JOIN services s ON cs.service_id = s.id
GROUP BY c.id;

```

---

3. Get Customers With No Services

```sql
SELECT c.*, s.*
 FROM customers c
  LEFT OUTER JOIN customers_services cs ON cs.customer_id = c.id
  FULL OUTER JOIN services s ON cs.service_id = s.id
WHERE cs.service_id IS NULL;
```
---

4. Get Services With No Customers

Using RIGHT OUTER JOIN, write a query to display a list of all services that are not currently in use. Your output should look like this:

```sql
 One-to-one Training
(1 row)
```
```

---

LS solution

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

---

5. Services for each Customer

```sql

SELECT DISTINCT c.*, STRING_AGG(s.description, ', ') AS services_registed_to
 FROM customers c
  LEFT OUTER JOIN customers_services cs ON cs.customer_id = c.id
  LEFT OUTER JOIN services s ON cs.service_id = s.id
GROUP BY c.id
ORDER BY c.id;

```

---

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

---

7. Total Gross Income

Assuming that everybody in our database has a bill coming due, and that all of them will pay on time, write a query to compute the total gross income we expect to receive.

```
Answer:

  gross
 --------
 678.50
(1 row)
```

```sql
SELECT SUM(s.price)
  FROM services s
    INNER JOIN customers_services cs ON cs.service_id = s.id;
```

This query does not require a second table because we can get all the data we need from `services`, which contains all `price` columns and `customers_services`, which contains all instances of customer and service relationships. From this we can get the sum of services who have a connection to a customer since each `service_id` is tied to a `customer_id` in the `customers_services` table.

---

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

---

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
