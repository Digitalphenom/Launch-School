1. The books_categories table from this database was created with foreign keys that don't have the NOT NULL and ON DELETE CASCADE constraints. Go ahead and add them now.

```sql
ALTER TABLE book_categories
DROP CONSTRAINT book_categories_book_id_fkey
ADD FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE

ALTER TABLE book_categories
DROP CONSTRAINT book_categories_category_id_fkey
ADD FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE

ALTER TABLE book_categories
ALTER COLUMN book_id SET NOT NULL

ALTER TABLE book_categories
ALTER COLUMN category_id SET NOT NULL

```
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

2. Write a SQL statement that will return the following result:

 id |     author      |           categories
----+-----------------+--------------------------------
  1 | Charles Dickens | Fiction, Classics
  2 | J. K. Rowling   | Fiction, Fantasy
  3 | Walter Isaacson | Nonfiction, Biography, Physics
(3 rows)

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

This table joins authors and they're book categories. To get the correct output, first associate the total books written by each author then aggregate each category for each book written. This looks like I'd need 2 JOIN tables

▣ Books to find total authors
▣ Categories and book_categories to associate each book to its category then associate each category group to a author.

```sql
SELECT b.author, STRING_AGG(c.name, ', ') FROM books_categories bc
LEFT JOIN books b ON b.id = bc.book_id
LEFT JOIN categories c ON c.id = bc.category_id
GROUP BY b.author
ORDER BY b.author;
```

fsf# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

3. Write SQL statements to insert the following new books into the database. What do you need to do to ensure this data fits in the database?

I would first add the new values into the database. Each author is new so id begin 
there along with titles of each book.

Then i'd add each new category:
  ▣ Space Exploration
  ▣ Cookbook
  ▣ South Asia

Once that's done update the JOIN table with each new author & category

```sql

ALTER TABLE books
ALTER COLUMN title TYPE text;

INSERT INTO books (title, author)
  VALUES
    ('Sally Ride: America''s First Woman in Space', 'Lynn Sherr'),
    ('Jane Eyre', 'Charlotte Bront'),
    ('Vij''s: Elegant and Inspired Indian Cuisine', 'Vikram Vij'),
    ('Vij''s: Elegant and Inspired Indian Cuisine', 'Meeru Dhalwala');

INSERT INTO categories (name)
  VALUES
    ('Space Exploration'),
    ('Cookbook'),
    ('South Asia');

INSERT INTO books_categories (book_id, category_id)
  VALUES
    (4, 1),
    (4, 5),
    (4, 6),
    (5, 2),
    (5, 4),
    (6, 8),
    (6, 1),
    (6, 9);


```