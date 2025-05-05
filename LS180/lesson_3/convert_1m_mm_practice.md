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