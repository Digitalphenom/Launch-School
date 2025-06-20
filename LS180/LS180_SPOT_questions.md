## 1. Consider the last line of the following code. Will the code result in an error if we attempt to insert NULL value to a student_id column? Why or why not?

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name text
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	student_id INT,
  FOREIGN KEY (student_id) REFERENCES students (id)
);

INSERT INTO students (name) VALUES ('Johny'), ('Edd');
INSERT INTO classes (name, student_d) 
	VALUES ('Math', 1), ('Art', NULL), ('Geography', 1);
```

Inserting a row with a NULL value attributed to `student_id` in the `classes` table will not raise an error because it does not break referential integrity since the table design does not enforce the foreign key with a `NOT NULL` constraint.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 1. Consider the code below. How are relations, tuples, attributes, and entities represented in the example below?

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teaachers (id) 
		ON DELETE CASCADE
);

INSERT INTO teachers (name) VALUES ('Marry Bee');
INSERT INTO classes (name, teacher_id) VALUES ('Math', 1);
```
 Entities represent some real world classification or thing, which is implemented into a database as a relation (table), which store collections of entity instances of the same type. A tuple refers to a single row within a relation and attributes` are the columns that define the characteristics of each entity.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


## 3. Consider the code below. How is a relation represented on the code below? How is a relationship represented?

```sql
CREATE TABLE teachers (
	id SERIAL PRIMARY KEY,
	name TEXT,
);

CREATE TABLE classes (
  id SERIAL PRIMARY KEY,
  name TEXT,
  teacher_id INT
  FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE
);

```

ANSWER: Relations in the preceding code are represented as `teachers` and `classes`. Conceptualy,the relationship between the two tables is `1:M` because each `teacher` can teach many `classes` and each class assigned one teacher. 

The physical implementation occurs via the `primary key` in `teachers`, which identifies unique rows and the `foreign key` in the `classes` table references that identifier and enforces referential integrity.

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 4. Considering the following code explain how defining keys and constraints ensures data integrity?

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teaachers (id) 
		ON DELETE CASCADE
);
```
ANSWER: The preceeding code ensures data integrity by enforcing referential integrity between tables. Referential integrity is enforced using the `FOREIGN KEY` of `classes` to reference the  `PRIMARY KEY` in the `teachers` table.

The `PRIMARY KEY` in `teachers` ensures that each *row is uniqueness and non-null*.

The `FOREIGN KEY` in `classes` guarantees that any value inserted must either match an existing `id` in the `teachers` table OR be `NULL` (if allowed).
This ensures that all references in the `classes` table are valid in relation to the `teachers` table, contributing to the overall data integrity of the database.


◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 5. What does data integrity mean in the context of SQL?
In SQL, strong data integrity means that data should remain correct, consistent, and reliable across all operations. 


## 6. How is data integrity enforced in SQL?
Data integrity is enforced by using constraints like PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, CHECK, and DEFAULT. Each constraint targets a specific type of integrity, such as entity integrity, referential integrity, or domain integrity, which ensures a database maintains valid and trustworthy data at all times.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 7. Explain how this SELECT query will be executed?

```sql
SELECT teachers.name, 
	FROM teachers
		JOIN classes
			ON teachers.id = classes.teacher_id
				GROUP BY teachers.name
					ORDER BY COUNT(classes.id);
```					
				 
A mental model for how this query executes begins with the JOIN clause. SQL conceptually loops through each row in the teachers table and compares it to all rows in the classes table, keeping the combinations where condition evaluates to true `teachers.id = classes.teacher_id`.

These joined rows are then grouped by teachers.name, so that all rows for the same teacher are collected into a single group.

The SELECT clause outputs each teacher name (one per group), and the ORDER BY clause sorts the results by the count of classes.id for each teacher, in ascending order.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 8. Will this code raise an error? Why or why not?

```sql
CREATE TABLE example(
	some_num numeric(10,2)
);

INSERT INTO example (some_num) VALUES (1);
```
This table creates a table named `example` and defines a single column named `some_num` witha  `NUMERIC(10,2)` data type, which can store numbers up to 10 digits total, including 2 digits after the decimal.

This code will not raise an error when inserting the digit `1` because PostgreSQL implicitly converts it to `1.00`, which is a valid value for a `NUMERIC(10, 2)` column.


◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 9. Will this code raise an error? Why or why not?

```sql
CREATE TABLE example(
	some_num int,
	some_text text CHECK (some_text > 0)
);

INSERT INTO example (some_num)
	VALUES (11);
```
This code does not rais an error. The `INSERT` only provides a value for `some_num` so `some_text` defaults to `NULL`. The `CHECK (some_text > 0)` constraint evaluates to `UNKNOWN` when `some_text` is `NULL`, and SQL only rejects rows where the check evaluates to `FALSE`. Therefore, the insert passes and the row is accepted.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 10. Consider the code below. Will this code raise an error? Why or why not?

```sql
CREATE TABLE some_table (
	some_num decimal(10,4) DEFAULT 'some text',
	some_t_or_f boolean DEFAULT true
);
```
This code raises an `invalid input syntax` error because it defines a `DEFAULT` value that is different from the data type that the table was created to accept.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 11. Consider the code below:
What values will be inserted into the table?
```sql
CREATE TABLE some_table(
	some_num decimal(10,4),
	some_t_or_f boolean DEFAULT true
);

INSERT INTO some_table (some_num, some_t_or_f)
	VALUES (11);
```

This code will not raise an error. The some_num column is given the value `11`, and the `some_t_or_f` column is explicitly set to `NULL`. Although `some_t_or_f` has a default value of `TRUE`, the default is ignored because a value `NULL` was explicitly provided. Therefore, the row inserted will contain `(11, NULL)`. 

Explicitly providing `NULL` overrides the `DEFAULT` constraint, which wont use the default value `TRUE` because defaults only apply when a column is *ommited* from the `INSERT` statement.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


## 12. Consider the following code. What does ON DELETE CASCADE do in this example?

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teaachers (id) 
		ON DELETE CASCADE
);
```
When the parent table (`teachers`) removes a row, the `ON DELETE CASCADE` clause  causes any rows in the child table (`classes`) that contain a matching `teacher_id` to also be deleted.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


## 13. Consider the table below: What indexes does this table have and what type of algorithms has been used for the indexing? Explain how they have been created:

```sql
my_books=# CREATE TABLE authors (
my_books(#   id serial PRIMARY KEY,
my_books(#   name varchar(100) NOT NULL
my_books(# );
CREATE TABLE
my_books=# CREATE TABLE books (
my_books(#   id serial PRIMARY KEY,
my_books(#   title varchar(100) NOT NULL,
my_books(#   isbn char(13) UNIQUE NOT NULL,
my_books(#   author_id int REFERENCES authors(id)
my_books(# );
```
```sql
CREATE TABLE
my_books=# \d books

Table "public.books"
Column     |          Type          |                     Modifiers
- ---------------+------------------------+----------------------------------------------------
id             | integer                | not null default nextval('books_id_seq'::regclass)
title          | character varying(100) | not null
isbn           | character(13)          | not null
author_id      | integer                |
Indexes:
"books_pkey" PRIMARY KEY, btree (id)
"books_isbn_key" UNIQUE CONSTRAINT, btree (isbn)
"books_author_id_idx" btree (author_id)
Foreign-key constraints:
"books_author_id_fkey" FOREIGN KEY (author_id) REFERENCES authors(id)
```

ANSWER:
The books table has three indexes, all using the default `btree` algorithm:

`"books_pkey"` is created automatically by the `PRIMARY KEY (id)` constraint. This ensures entity integrity by uniquely identifying each row

`"books_isbn_key"` is created by the `UNIQUE (isbn)` constraint. It enforces uniquenes
for ISBN numbers and supports fast lookups by isbn

`"books_author_id_idx"` is created automatically by `PostgreSQL` to optimize the
`FOREIGN KEY` constraint on `author_id`. This index improves performance when joinin
`books` with `authors`, and when validating *referential integrity*.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 14. If we create a table with an id column and specify it as serial, and we look at the schema of that table, what will be shown as a Type of id? Why?

ANSWER:
When a table is created with an `id` column defined as `SERIAL`, the columns data type will appear as `INTEGER` in the schema. Behind the scenes, `PostgreSQL` creates a separate `SEQUENCE` object and assigns the column a default value of `nextval('table_column_seq)`. This combination causes the column to auto-generate integer values when a new row is inserted. So while you wrote `SERIAL`, what you actually get is an `INTEGER` column with an attached auto-increment mechanism powered by a separate sequence.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 15. Consider the following code:

```sql
SELECT age, full_name FROM students
WHERE id < 2;

```
What type of statement is this code presenting? Explain all components of this statement.

This statement represents a `SELECT` statement. It uses a `SELECT` clause to retreive values from the `age` and `full_name` columns. The `FROM` clause specifies the table to retrieve said values from. Then the `WHERE` clause specifies the criteria by which rows should be displayed in. So, in full this `SELECT` statement specifies that we should retrieve values from the `age` and `full_name` column in the `students` table where the `id` column value is less than 2.


◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

```sql
CREATE TABLE students(
  id SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  year_of_birth TIMESTAMP,
  grade TEXT CHECK (grade IN (
    'A', 'A-', 'A+', 
    'B', 'B-', 'B+',
    'C', 'C-', 'C+'
    ))
);

SELECT name FROM students
WHERE EXTRACT(MONTH FROM year_of_birth) = 4;

INSERT INTO students(name, year_of_birth, grade)
VALUES ('Eddie', '1986-01-01', 'A'),
('Maggie', '1975-04-11', 'B+'),
('Elenore', '1995-03-13', 'A-');

SELECT * FROM students
WHERE EXTRACT(YEAR FROM year_of_birth) = 1986;

SELECT * FROM students
GROUP BY id
ORDER BY EXTRACT(YEAR FROM year_of_birth) ASC
LIMIT 1;

--OR

SELECT *
FROM students
WHERE year_of_birth = (
  SELECT MIN(year_of_birth) FROM students
);
```

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 16. Why do we need to create multiple tables instead of just keeping all the data in one table?

We create multiple tables through the process of normalization, which aims to reduce data redundancy and maintain data integrity. Normalization organizes data into logically related tables, which eliminate *update*, *delete* and *insertion* anomalies that commonly arise when redundant or poorly stuctured data is stored in a single table.

## 17. When do we normalize data?

We normalize data to model relationships between data entities more accurately and to avoid redundancy."

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 18. Consider the following students table:

id |    name    |    year_of_birth    |    grade |  class
-----------------------------------------------------------
1  |  'Eddie'   |   1986-01-01        |   A      |  Math
2  |  'Maggie'  |   1975-04-11        |   B+     |  History
3  |  'Elenore' |   1995-03-13        |   A-     |  French

1. We no longer want to have classes at the same table as students. What are thsteps you would take to create another table classes and create a relationshibetween students and classes.

2. Create classes table and the relationship between classes and students.


ANSWER: I would normalize the table to more accurately model entity relationships where `class` and `students` are separate tables linked via `PRIMARY` and `FOREIGN` keys. In terms of cardinality, since a single `class` instance can have many `student` associations and multiple `class` instances can also be associated to a single `student` i.e(multiple students can attend a single class, and each student can attend multiple classes) the cardinality is `M:M` requiring a `join table`. Each entry in the join table must reference an existing student (required), while participation in a class is optional at the business logic level, but required in the join table.

```sql
ALTER TABLE students
DROP COLUMN class;

CREATE TABLE classes(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE students_classes(
  student_id INT NOT NULL,
  class_id INT NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (class_id) REFERENCES classes(id),
  UNIQUE (student_id, class_id)
);
```
◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 19. What is cardinality in database design, and why is it important to identify it when modeling table relationships?

Cardinality in database design refers to the number of instances of one entity that can be associated with instances of another entity. The three most common types are one-to-one (1:1), one-to-many (1:M), and many-to-many (M:M). Identifying cardinality is important because it helps model real-world relationships accurately in an entity-relationship diagram before database implementation. Once the cardinality of a relationship is determined, it informs how tables, foreign keys, and join tables should be structured. Skipping this step can lead to inconsistent or inefficient database schemas that don't reflect the intended data relationships.


◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 20. Consider the following diagram. Describe what is the cardinality between entities?

Director ----------> Film

The ERD defines two entities: `director` and `film`.
The director entity establishes a `1:M` relationship, indicating that a single director can be associated with multiple `film` instances, but each `film` instance can only be associated with a single `director`. This suggests a cardinality of `1:M`. However, real world constraints imply a cardinality of `M:M`, since `films` can be co-directed by multiple directors and directors can direct multiple films.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 21. Consider two tables below:

SELECT * FROM customers;
customer_id | name  
-------------+-------
           1 | Johny
           2 | Ben
           3 | Gary

SELECT * FROM orders;
order_id | customer_id | orders 
----------+-------------+--------
        1 |           1 | book
        2 |           2 | mug
        3 |           3 | chair

\d orders 

Column    |  Type   | Collation | Nullable |                 Default                  
-------------+---------+-----------+----------+------------------------------------------
 order_id    | integer |           | not null | nextval('orders_order_id_seq'::regclass)
 customer_id | integer |           |          | 
 orders      | text    |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "orders_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(customer_id)

- What will happen if we run the following statement? Why?


ANSWER: If we execute `DELETE FROM customers WHERE customer_id = 3`, Postgres will raise an error due to the `FOREIGN KEY` constraint defined in the `orders` table. Specifically the row in `orders` with `customer_id = 3` still exists and references the `customers` table.

Since `FOREIGN KEYS` enforce *referential integrity*, Postgres prevents deletion of a referenced row to ensure that all values in the `orders.customer_id` column remain valid. This means that each row must correspond to an existing `customers.customer_id` value, which protects the consistency and correctness of relationships between tables.

To get past this error we should ensure to add an `ON DELETE CASCADE` so that removing a row from a parent table automatically removes a referenced row from the child table. If we fail to do this, we must first `DROP` the `FOREIGN KEY` constraint:

```sql
ALTER TABLE orders
DROP CONSTRAINT orders_customer_id_fkey;
```
And then re-add the `FOREIGN KEY` with an `ON DELETE CASCADE` clause:

```sql
ALTER TABLE orders
ADD CONSTRAINT orders_customer_id_fkey
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;
```
◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 22. Consider the code below. What type of cardinality does this example present? Explain how did you deduce that.

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
		ON DELETE CASCADE
);
```

This table implementation enforces a `1:1` cardinality. I deduced this from the `PRIMARY KEY` (`student_id`) constraint in the `addresses` table, which prevents multiple rows from using the same `student_id`. The `FOREIGN KEY` constraint ensures that each `address` belongs to a valid `student`, but the uniqueness enforced by the primary key limits each student to at most one address. Therefore, each `student` can be associated with at most one `address`, and each `address` corresponds to exactly one `student`.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 23. Why can we add a student without an address but can't add an address without a student?

```sql
 CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
		ON DELETE CASCADE
);
```

We are referencing the id from the address table, which is responsible for enforcing referntial integrity. The student table does not directly associate with address so can freely add data. Its in the address table where the relationship is enforced.

This entity relationship enforces a cardinality of `1:1`. This means that every `student` instance should associate to exactly one unique `address`. However, the address and city columns in `addresses` do not define `NOT NULL` constraints, leading to the potential for a `student` to be entered into the `addresses` table without an associated address or city. But the opposite is not possible because the `student_id` in `addresses` is enforced with both a `PRIMARY KEY` and a `FOREIGN KEY` constraint. The `PRIMARY KEY` adds both `UNIQUE` and `NOT NULL` constraints, ensuring that each address must be associated with a valid `student`.

 ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


## 24. Consider two tables below:

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
);
```

What will happen if we delete a row in a students table, that is referenced by a record in addresses table?

ANSWER: Removing a row in the `students` table that is referenced by `student_id` in the `addresses` table will raise an error because the `student_id` column enforces a `FOREIGN KEY` constraint. This constraint ensures that referenced values *remain valid*, preserving referential integrity. Deleting a `student` that is still referenced in `addresses` would violate that integrity, so SQL prevents the deletion and raises an error.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 25. Consider two tables below:
```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics

table 'students'

id | name  | class_id 
----+-------+----------
  1 | Harry |        1
  2 | Ben   |        2
  3 | Marry |        3
  4 | Marry |        2
```

Describe what the following statement will do and what will be the result of the query:

```sql
SELECT students.name as "Student Name", classes.name as "Class name"
	FROM students 
	INNER JOIN classes 
	ON students.class_id = classes.id;
```
ANSWER: This SQL statements, uses an `INNER JOIN` with the *join condition* `students.class_id = classes.id` to create a transient table that returns row pairs where the *join condition* evaluates to `TRUE`. The `SELECT` clause then retrieves the `students.name` and `classes.name`, both aliased for readability. The returned set includes only students that have a `students.class_id` matching a row in `classes.id`. The result should look something like this:

Student Name | Class name
-------------+-----------+
   Harry     |  math
   Ben       |  german
   Mary      |  physics
   Mary      |  german

1. What steps did PostgreSQL take in order to perform the query?

The steps taken in their respective order:

Evaluate the `FROM` clause and `JOIN` operation, Postgre first identifies th
tables involved and applies the `INNER JOIN` using the condition `students.class_i = classes.id`. This produces a transient table containin only rows where the join condition evaluates to `TRUE`

Apply the `SELECT` clause From the joined result, PostgreSQL extracts only th
columns specified in the `SELECT` clause `students.name` and `classes.name`, renaming
them using aliases as necessary.


◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 26. Describe how a 'join table' looks like. How many columns does it contain and what would their names be? What rows would be included in that table?

A *join table* is used in a database when the cardinality between two tables is `M:M`. The join table defines columns with the `INTEGER` data type and a `FOREIGN KEY` constraint that reference the `PRIMARY KEY`s in the parent tables they connect. These are implemented as `FOREIGN KEY (table_id) REFERENCES parent_table(id)`.

Each column also enforces a `NOT NULL` constraint to ensure that no row is missing a reference and a composite `PRIMARY KEY` or `UNIQUE` constraint, applied across foreign key columns to ensure that each `(a_id, b_id)` pair appears only one.

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 27. Consider the following tables:

```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics

table 'students'

 id | name  | year_of_birth | class_id 
----+-------+---------------+---------
  1 | Harry |  1987-02-04   |      1
  2 | Ben   |  1976-11-13   |      2
  3 | Marry |  1995-03-21   |      3
  4 | Marry |  1995-03-21   |      2

```
Write a query:
    return a list of students names who are born in 90' and attend German classes
    return a list of students born in February along with a class they attend.
  
```sql
SELECT students.name AS "Students" 
  FROM students
    INNER JOIN classes ON students.class_id = classes.id
    WHERE EXTRACT(YEAR FROM year_of_birth) BETWEEN 1990 AND 1999 AND 
    classes.name = "german";

SELECT * AS "Students" 
  FROM students
    INNER JOIN classes ON students.class_id = classes.id
    WHERE EXTRACT(MONTH FROM year_of_birth) = 2;
```

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 28. Consider the schema below:

```sql

Table "public.birds"
 Column  |         Type          | Collation | Nullable |              Default              
---------+-----------------------+-----------+----------

+-----------------------------------
 id      | integer               |           | not null | nextval('birds_id_seq'::regclass)
 name    | character varying(25) |           |          | 
 age     | integer               |           |          | 
 species | character varying(15) |           |          | 
Indexes:
    "birds_pkey" PRIMARY KEY, btree (id)

```

Let say we alter the table with the following command:

```sql
ALTER TABLE birds ADD CHECK (age > 0);
```
1. Explain what this command does and where will the information be added to the schema?

ANSWER: The SQL statement adds a `CHECK` constraint at the table level, which enforces the condition `age > 0` whenever values are inserted into or updated in the  `age` column. If a value fails to meet the condition, the database raises an error and rejects the operation.

 ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 29. Consider the following students table:

```sql

 id | name  | year_of_birth | phone_num     | class_id 
----+-------+---------------+---------------+---------
  1 | Harry |  1987-02-04   |  909432987    |  1
  2 | Ben   |  1976-11-13   |  099876567    |  2
  3 | Marry |  1995-03-21   |  098787654    |  3
  4 | Marry |  1995-03-21   |  908675356    |  2

```
Add following constraints to the table:
  - if there is no name given anonymous should be added
  - class_id should always be grater than 0
  - phone_num should not allow duplicates
  - year_of_birth should be obligatory

```sql
ALTER TABLE students
ALTER COLUMN name SET DEFAULT 'anonymous';

ALTER TABLE students
ADD CHECK (class_id > 0);

ALTER TABLE students
ADD UNIQUE (phone_num);

ALTER TABLE students
ALTER COLUMN year_of_birth SET NOT NULL;
```

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 30. Consider students table below:

```sql
id | name  |year_of_birth|phone_num    | average_points 
----+-------+---------------+---------------+---------
 1 | Harry | 1987-02-04 |  909432987   |  1
 2 | Ben   | 1976-11-13 |  099876567   |  6
 3 | Marry | 1995-03-21 |  098787654   |  7
 4 | Marry | 1995-03-21 |  908675356   |  0

The schema is as follow:

Table "public.students"
     Column     |  Type   | Collation | Nullable |               Default                
----------------+---------+-----------+----------+--------------------------------------
 id             | integer |           | not null | nextval('students_id_seq'::regclass)
 name           | text    |           | not null | 
 year_of_birth  | text    |           |          | 
 phone_num      | text    |           |          | 
 average_points | integer |           |          | 
Indexes:
    "students_pkey" PRIMARY KEY, btree (id) 
```

  - change name data type to take strings with max length of 50
  - change year_of_birth data type to DATE
  - change phone_num data type to be an integer
  - change average_points to be able to take decimal point numbers that must be-      greater than 0 but less than 10
  - add a new column called highest_grade that is obligatory and can take a string- with max length of 1 character.
  - now change the data type of highest_grade to only accept one of the following- characters: ('A', 'B', 'C', 'D', 'F')

```sql
ALTER TABLE students
ALTER COLUMN name TYPE varchar(50);

ALTER TABLE students
ALTER COLUMN year_of_birth TYPE DATE;

ALTER TABLE students
ALTER COLUMN phone_num TYPE INTEGER
USING phone_num::INTEGER;
-- OR
USING phone_num::BIGINT;


ALTER TABLE students
ALTER COLUMN average_points TYPE DECIMAL
ALTER TABLE students
ADD CHECK (average_points BETWEEN 1 AND 9);
--OR
ADD CHECK (average_points > 0 AND aberage_points < 10);

ALTER TABLE students
ADD COLUMN highest_grade VARCHAR(1) NOT NULL;
ALTER TABLE students
ADD CHECK (highest_grade IN ('A', 'B', 'C', 'D', 'F'))
--OR
ADD CHECK (highest_grade ~ ('[ABCDF]'))


```

Remember that data is already inputted in the table.


◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 31. Write all possible ways to insert data into the table where the only data we have is the name 'John'. (take advantage of the DEFAULT value).

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) NOT NULL,
  year_of_birth date,
  passed boolean DEFAULT true  
);

INSERT INTO students("name")
VALUES ('John')

INSERT INTO students
VALUES (NULL, 'John', NULL, NULL)

INSERT INTO students(id, "name")
VALUES (NULL, 'John', NULL)
```

◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

## 32. Imagine you have two tables below:

```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics
  4 | french

table 'students'

 id | name  | year_of_birth | 
----+-------+---------------+
  1 | Harry |  1987-02-04   |  
  2 | Ben   |  1976-11-13   | 
  3 | Marry |  1995-03-21   | 
  4 | John  |  1994-13-21   |  

table 'students-classes'

 id | class_id | student_id | 
----+----------+------------+
  1 |      1   |   1
  2 |      2   |   2
  3 |      3   |   3
  4 |      2   |   3
```

What will be the result if we run the following query:

```sql
SELECT students.name, classes.name 
  FROM students
  JOIN students_classes
    ON students_classes.students_id = students.id
    JOIN classes
      ON classes.id = students_classes.class_id;
```

Harry => Math
Ben => German
Marry => Physics
Marry =>  German
