CREATE TABLE expenses(
  id SERIAL PRIMARY KEY,
  amount NUMERIC(6,2) NOT NULL,
  memo VARCHAR(255) NOT NULL,
  created_on DATE NOT NULL
);

ALTER TABLE expenses
ADD CHECK ( amount >= 0.01 );

INSERT INTO expenses(amount, memo, created_on)
VALUES(14.56, 'Pencils', NOW()),
      (3.26, 'Coffee', NOW()),
      (49.99, 'Text Editor', NOW()),
      (40, 'Hair Cut', NOW());