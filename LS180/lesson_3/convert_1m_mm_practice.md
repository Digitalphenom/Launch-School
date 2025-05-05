# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

2. Write the SQL statement needed to create a join table that will allow a film to have multiple directors, and directors to have multiple films. Include an id column in this table, and add foreign key constraints to the other columns.

```sql
ALTER TABLE films
DROP COLUMN director_id;

CREATE TABLE directors_films(
  id SERIAL PRIMARY KEY,
  directors_id INT NOT NULL,
  films_id INT NOT NULL,
  
  FOREIGN KEY (directors_id) REFERENCES directors(id) ON DELETE CASCADE,
  FOREIGN KEY (films_id) REFERENCES films(id) ON DELETE CASCADE
);
```
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

3. Write the SQL statements needed to insert data into the new join table to represent the new many-to-many relationship.

```sql
INSERT INTO directors_films (films_id, directors_id)
  VALUES
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 3),
    (8, 7),
    (9, 8),
    (10, 4);
```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

5. Write a SQL statement that will return the following result:

```sql

SELECT f.title, d.name 
  FROM films f
    LEFT OUTER JOIN directors_films df ON df.films_id = f.id 
    LEFT OUTER JOIN directors d ON df.directors_id = d.id
  ORDER BY f.title;

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

6. Write SQL statements to insert data for the following films into the database:

```sql
INSERT INTO films(title, "year", genre, duration)
  VALUES
    ('Fargo', 1996, 'comedy', 98),
    ('No Country For old men', 2007, 'western', 122),
    ('Sin City', 2005, 'crime', 124),
    ('Spy Kids', 2001, 'scifi', 88);


INSERT INTO directors(name)
  VALUES
    ('Joel Coen'),
    ('Ethan Coen'),
    ('Frank Miller'),
    ('Robert Rodriguez');

INSERT INTO directors_films (films_id, directors_id)
  VALUES
    (11, 9),
    (12, 9),
    (12, 10),
    (13, 11),
    (14, 12),
    (13, 12);

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

7.

```sql
  SELECT d.name AS director, COUNT(df.films_id) AS films
  FROM directors d
    LEFT OUTER JOIN directors_films df ON df.directors_id = d.id
    --LEFT OUTER JOIN films f ON df.films_id = f.id
  GROUP BY d.id
  ORDER BY films DESC, d.name ASC;

```