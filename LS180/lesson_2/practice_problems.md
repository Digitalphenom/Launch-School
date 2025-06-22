1. What is the result of using an operator on a NULL value?

The result of using an operator on a NULL value is nothing or `NULL` because unlike Ruby where `nil` can be directly compared against to obtain a truthy value. `NULL` refers to nothing in the literal sense, thus cannot be compared with anything, not even `NULL` itself.

--------

2. Set the default value of column department to "unassigned". Then set the value of the department column to "unassigned" for any rows where it has a NULL value. Finally, add a NOT NULL constraint to the department column.

```sql
CREATE TABLE employees (
    first_name character varying(100),
    last_name character varying(100),
    department character varying(100),
    vacation_remaining integer
);

INSERT INTO employees VALUES ('Leonardo', 'Ferreira', 'finance', 14);
INSERT INTO employees VALUES ('Sara', 'Mikaelsen', 'operations', 14);
INSERT INTO employees VALUES ('Lian', 'Ma', 'marketing', 13);

ALTER TABLE employees
ALTER COLUMN department SET DEFAULT 'unassigned';

UPDATE employees SET department = 'unassigned'
WHERE department IS NULL;

ALTER TABLE employees
ALTER COLUMN department SET NOT NULL;
```

--------

3. Write the SQL statement to create a table called temperatures to hold the following data:

```sql
CREATE TABLE temperatures(
  date DATE,
  low INT,
  high INT,
);

INSERT INTO temperatures
  VALUES
    ('2016-03-01', 34, 43),
    ('2016-03-02', 32, 44),
    ('2016-03-03', 31, 47),
    ('2016-03-04', 33, 42),
    ('2016-03-05', 39, 46),
    ('2016-03-06', 32, 43),
    ('2016-03-07', 29, 32),
    ('2016-03-08', 23, 31),
    ('2016-03-09', 17, 28);

ALTER TABLE temperatures
ALTER COLUMN date SET NOT NULL,
ALTER COLUMN low SET NOT NULL,
ALTER COLUMN high SET NOT NULL;
```

--------

5. Write a SQL statement to determine the average (mean) temperature (divide the sum of the high and low temperatures by two) for each day from March 2, 2016 through March 8, 2016. Make sure to round each average value to one decimal place.

```sql
SELECT date, ROUND((high + low) / 2.0, 1) AS average_temperatures FROM temperatures
WHERE date BETWEEN  '2016-03-02' AND '2016-03-08';

```

--------

6. Write a SQL statement to add a new column, rainfall, to the temperatures table. It should store millimeters of rain as integers and have a default value of 0.

```sql
ALTER TABLE temperatures
ADD COLUMN rainfall INT DEFAULT 0;
```
--------

7. Each day, it rains one millimeter for every degree the average temperature goes above 35. Write a SQL statement to update the data in the table temperatures to reflect this.

```sql
UPDATE tempatures
    SET rainfall = ROUND(high + low) / 2.0- 35
  WHERE (high + low) / 2 > 35;

```