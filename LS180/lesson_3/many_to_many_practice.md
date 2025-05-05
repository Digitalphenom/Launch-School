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