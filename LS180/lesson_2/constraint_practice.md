
2. Modify all of the columns to be NOT NULL

```sql
ALTER TABLE films
  ALTER COLUMN title SET NOT NULL,
  ALTER COLUMN year SET NOT NULL,
  ALTER COLUMN genre SET NOT NULL,
  ALTER COLUMN director SET NOT NULL,
  ALTER COLUMN duration SET NOT NULL;
```

3. How does modifying a column to be NOT NULL affect how it is displayed by \d films?

Adding a `NOT NULL` constraint adds it to that columns `Nullable` column. 

4. Add a constraint to the table films that ensures that all films have a unique title.

```sql
ALTER TABLE films
ADD CONSTRAINT unique_title UNIQUE (title);
```

5. How is the constraint added in #4 displayed by \d films?
  
  Its displayed at the very bottom under `indexes`.


6. Write a SQL statement to remove the constraint added in #4.

```sql

ALTER TABLE films
DROP UNIQUE unique_title;

```

7. Add a constraint to films that requires all rows to have a value for title that is at least 1 character long.

```sql
ALTER TABLE films
ADD CONSTRAINT title_length CHECK (length(title) >= 1);
```

8. What error is shown if the constraint created in #7 is violated? Write a SQL INSERT statement that demonstrates this.

```sql

INSERT INTO films
VALUES ('', 1973, 'Horror', 'William Friedkin', 122);

```

10. Write a SQL statement to remove the constraint added in #7.

```sql

ALTER TABLE filsm
DROP CONSTRAINT title_length; 

```

11. Add a constraint to the table films that ensures that all films have a year between 1900 and 2100.

```sql
ALTER TABLE films
ADD CONSTRAINT year_length CHECK (year >= 1900 AND year <= 2100)
                                 (year BETWEEN 1900 AND 2100)

```

13. Add a constraint to films that requires all rows to have a value for director that is at least 3 characters long and contains at least one space character ().

```sql

ALTER TABLE films
ADD CONSTRAINT director_length CHECK (length(director) >= 3 AND director LIKE '% %' )

```

15. Write an UPDATE statement that attempts to change the director for "Die Hard" to "Johnny". Show the error that occurs when this statement is executed.


```sql

UPDATE films SET director = 'Johnny' WHERE title = 'Die Hard';v

```

```sql
NOT NULL,
UNIQUE,
DEFAULT TRUE,
CHECK (length(car_owner) > 5)
```

```sql
CREATE TABLE test_2(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) DEFAULT 'joe' CHECK (length(name) > 3)
);

INSERT INTO test_2 (name)
  VALUES 
    ('');
```

```sql
ALTER TABLE films
ADD CONSTRAINT val DEFAULT ()

```


















