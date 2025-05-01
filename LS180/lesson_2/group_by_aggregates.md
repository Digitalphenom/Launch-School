
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

2. Write SQL statements that will insert the following films into the database:

```sql 

INSERT INTO films (title, year, genre, director, duration)
  VALUES 
    ('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95),
    ('Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);

```
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

3. Write a SQL query that lists all genres for which there is a movie in the films table.

```sql 

SELECT DISTINCT genre FROM films;

``` 

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

4. Write a SQL query that returns the same results as the answer for #3, but without using DISTINCT.

```sql 

SELECT genre FROM films
WHERE count(genre) = 1;

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞ 

5. Write a SQL query that determines the average duration across all the movies in the films table, rounded to the nearest minute.

```sql 
SELECT ROUND(AVG(duration)) FROM films;

``` 


# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

6. Write a SQL query that determines the average duration for each genre in the films table, rounded to the nearest minute.

```sql 
SELECT genre, ROUND(AVG(duration)) FROM films
GROUP BY genre;


``` 

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

7. Write a SQL query that determines the average duration of movies for each decade represented in the films table, rounded to the nearest minute and listed in chronological order.

```sql
SELECT (year / 10) * 10 AS decade, ROUND(AVG(duration)) FROM films
GROUP BY decade
ORDER BY decade;

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞



8. Write a SQL query that finds all films whose director has the first name John.

```sql
SELECT * FROM films WHERE director LIKE '%John%';
```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

9. Write a SQL query that will return the following data:

   genre   | count
-----------+-------
 scifi     |     5
 comedy    |     4
 drama     |     2
 espionage |     2
 crime     |     1
 thriller  |     1
 horror    |     1
 action    |     1
(8 rows)

```sql
SELECT genre, count(genre) FROM films
GROUP BY genre
ORDER BY count DESC;
``` 

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


10. Write a SQL query that will return the following data:

 decade |   genre   |                  films
--------+-----------+------------------------------------------
   1940 | drama     | Casablanca
   1950 | drama     | 12 Angry Men
   1950 | scifi     | 1984
   1970 | crime     | The Godfather
   1970 | thriller  | The Conversation
   1980 | action    | Die Hard
   1980 | comedy    | Hairspray
   1990 | comedy    | Home Alone, The Birdcage, Wayne's World
   1990 | scifi     | Godzilla
   2000 | espionage | Bourne Identity
   2000 | horror    | 28 Days Later
   2010 | espionage | Tinker Tailor Soldier Spy
   2010 | scifi     | Midnight Special, Interstellar, Godzilla
(13 rows)

```sql
SELECT (year / 10) * 10 AS decade, genre, title AS films FROM films
GROUP BY decade, genre
ORDER BY decade;
```


# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞
11. Write a SQL query that will return the following data:

   genre   | total_duration
-----------+----------------
 horror    |            113
 thriller  |            113
 action    |            132
 crime     |            175
 drama     |            198
 espionage |            245
 comedy    |            407
 scifi     |            632
(8 rows)


```sql
SELECT genre, SUM(duration) AS total_duration FROM films
GROUP BY genre
ORDER BY total_duration, genre;

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

```sql

INSERT INTO products (product_name, supplier_name, cost, price)
  VALUES ('Small Widget', 'The Widget Company', 3.22, 5.00),
         ('Large Widget', 'The Widget Company', 4.68, 8.00);

B

INSERT INTO products (product_name, supplier_name, cost, price)
  VALUES ('Medium Widget', 'The Widget Company', 3.92, 6.50),
         ('Medium Widget', 'Bob''s Widgets', 3.87, 6.50);

C

INSERT INTO products (product_name, supplier_name, cost, price, stock)
  VALUES ('Red Gizmo', 'Gizmos R Us', 4.00, 4.00, 20),
         ('Green Gizmo', 'Gizmos R Us', 4.00, 4.00, 15);

D

INSERT INTO products (product_name)
  VALUES ('Duplicator'),
         ('Transmogrifier');


```

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞



```sql

CREATE TABLE class_ice_cream_survery(
  name VARCHAR(50),
  age INT,
  favorite_flavor VARCHAR(255)
);

INSERT INTO class_ice_cream_survery (name, age, favorite_flavor) VALUES
  ('Afia', 6, 'Strawberry'),
  ('Ben', 6, 'Chocolate'),
  ('Clara', 6, 'Strawberry'),
  ('David', 7, 'Rocky Road'),
  ('Emma', 6, 'Vanilla'),
  ('Jian', 7, 'Chocolate'),
  ('Juana', 6, 'Chocolate'),
  ('Kayla', 7, 'Vanilla'),
  ('Michael', 6, 'Chocolate'),
  ('Sofia', 7, 'Chocolate'),
  ('Taylor', 6, 'Strawberry'),
  ('Zoe', 7, 'Chocolate');




SELECT DISTINCT favorite_flavor AS flavor, count(favorite_flavor), age
FROM class_ice_cream_survery
GROUP BY flavor;


```

Conceptual schema is a schema that defines entities and their relationships without concern for specific implementation of said schema.

A physical schema is the direct application of a conceptual schema. For examle the exact data types and constraints that a schema contains.

one-to-one
one-to-many
many-to-many


modality of one means a requirment of some data, which would mean that an instance of exactly one should exist.

INSERT INTO directors (name)
  VALUES
    ('John McTiernan'),('Michael Curtiz'), ('Francis Ford Coppola'),
    ('Michael Anderson'), ('Tomas Alfredson'), ('Mike Nichols');


UPDATE films SET director_id=1 WHERE director = 'John McTiernan';
UPDATE films SET director_id=2 WHERE director = 'Michael Curtiz';
UPDATE films SET director_id=3 WHERE director = 'Francis Ford Coppola';
UPDATE films SET director_id=4 WHERE director = 'Michael Anderson';
UPDATE films SET director_id=5 WHERE director = 'Tomas Alfredson';
UPDATE films SET director_id=6 WHERE director = 'Mike Nichols';