CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
);

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

CREATE TABLE workspace (
  id SERIAL PRIMARY KEY,
  workspace_name VARCHAR(50),
  owner_id INT UNIQUE,
  FOREIGN KEY (owner_id) REFERENCES employee(id)  ON DELETE CASCADE
);

CREATE TABLE workspace (
  owner_id int PRIMARY KEY,
  workspace_name varchar(50), NOT NULL,
  FOREIGN KEY (owner_id) REFERENCES employee (id) ON DELETE CASCADE
);

INSERT INTO continents (id, continent_name)
VALUES
  (1, 'Europe'),
  (2, 'North America'),
  (3, 'South America'),
  (4, 'Central America'),
  (5, 'Asia'),
  (6, 'Africa');

INSERT INTO more_countries (id, name, capital, population, continent_id)
VALUES (1, 'France', 'Paris', 67158000, 1),
  (2, 'USA', 'Washington D.C', 325365189, 2),
  (3, 'Germany', 'Berlin', 82349400, 1),
  (4, 'Japan', 'Tokyo', 126672000, 5),
  (5, 'Egypt', 'Cairo', 96308900, 6),
  (6, 'Brazil', 'Brasilia', 208385000, 3);

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

CREATE TABLE singers(
  id SERIAL PRIMARY KEY,
  Name VARCHAR(50)
);f

CREATE TABLE albums(
  id SERIAL PRIMARY KEY,
  Album_Name VARCHAR(50),
  Genre VARCHAR(50),
  Label VARCHAR(50),
  singer_id INT NOT NULL,
  FOREIGN KEY singer_id REFERENCES singers(id) ON DELETE CASCADE
);

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
);

CREATE TABLE email_addresses (
  customer_id INT PRIMARY KEY,
  email_address VARCHAR(100) NO NULL,
  FOREIGN KEY customer_id REFERENCES customers(id) ON DELETE CASCADE
);

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  Product_Name VARCHAR(20),
  Product_Cost NUMERIC(4,1),
  Product_Type VARCHAR(50),
  Product_Loyalty_Points INT
);

INSERT INTO products (Product_Name, Product_Cost, Product_Type, Product_Loyalty_Points)
VALUES 
('LS Cheeseburger', 3.50, 'Burger', 15 ),q
('LS Chicken Burger', 4.50, 'Burger', 20 ),
('LS Double Deluxe Burger', 6.00, 'Burger', 30 ),
('Fries', 1.20, 'Side', 3 ),
('Onion Rings', 1.50, 'Side', 5 ),
('Cola', 1.50, 'Drink', 5 ),
('Lemonade', 1.50, 'Drink', 5 ),
('Vanilla Shake', 2.00, 'Drink', 7 ),
('Chocolate Shake', 2.00, 'Drink', 7 ),
('Strawberry Shake', 2.00, 'Drink', 7);

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

CREATE TABLE customers (
  id SERIAL PRIMARY KEY, 
  customer_name VARCHAR(50)
  );

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  product_name VARCHAR(50),
  product_cost DECIMAL(4, 1),
);

CREATE TABLE order_items (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT,
  order_quantity INT,

  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL,
  order_status VARCHAR(20),

  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

# In this scenario, each book is unique, but we can have multiple copies of the same book. The table can store multiple books. Each checkout is unique, but there can be multiple checkouts associated to multiple books. This would thus form a one to many relationship where each unique checkout can contain multiple books.

CREATE TABLE book (
  id SERIAL PRIMARY KEY,
  book_name VARCHAR(50),
  isbn INT UNIQUE,
);

CREATE TABLE checkout (
  id SERIAL PRIMARY KEY,
  book_id INT NOT NULL,
  checkout_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
)

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

# Movies and Screenings
# Each movie is unique and each screening is also unique. When modeling a table each table can have multiple movies and screening, however each movie can be viewed multiple times across multiple screenings.

# Each screening can show only one movie but there can be multiple movies but each movie is unique. This makes movies the one and screenings the multple. Since there can be multiple screenings but only one movie. 

movie 1
movie 2
movie 3

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
screening 1 movie 1
screening 2 movie 1
screening 3 movie 3

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

movie 1 screening 1
movie 2 screening 1
movie 3 screening 2

# Each screening can only show one movie but each movie can be screened multiple times therefore movies is the many and screenings is the one.

CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  movie_name VARCHAR(50) UNIQUE,
)

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  movie_id INT NO NULL,

  FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

Each grocery chain can have multiple customers but each customer can visit only one chain at a time. Therefore the customers is the many and the grocery store is the one.

A screening can show many movies, but a movie can only be shown 

There are many movies, but each movie can only be shown at one screening. Therefore movies is the one and screening is the many.

Ok im gonna give it a stab
Watch/Person
A person can wear many watches, but there can only be a single watch at a time. The watch is the one and people are the many.

Users/email
Each user can have multiple emails but each email is unique.
This would proably form a one-to-one relationship because there can only be one person who owns a unique email. However, in the context of a company who own several emails, would form a single-to-many relationship with the company being the single and email being many.

Player/women
A player can have multiple women, but each women can only rear a single child at a time. The player is the one and the women is the many.


SELECT enrollments.id, students.name, courses.course_name
FROM enrollments
JOIN students ON enrollments.student_id = students.id
JOIN courses  ON enrollments.course_id = courses

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

CREATE TABLE singers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

CREATE TABLE albums (
  id serial PRIMARY KEY,
  album_name varchar(100),
  released date,
  genre varchar(100),
  label varchar(100),
  singer_id int,
  FOREIGN KEY (singer_id) REFERENCES singers(id) ON DELETE CASCADE

  #◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  course_name VARCHAR(100)
);

CREATE TABLE enrollments (
  id SERIAL PRIMARY KEY,
  student_id INT,
  course_id INT,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

SELECT o.id
FROM orders o
JOIN product p ON o.order_id = p.id
WHERE p.name = 'Fries';


SELECT o.name AS 'Customer who like fries'
FROM orders AS o 
JOIN order_items AS oi ON o.id = oi.order_id
JOIN products AS p ON o.product_id = p.id
WHERE p.product_name = 'Fries';

SELECT DISTINCT c.customer_name AS "Customers who like Fries"
FROM customers AS c
JOIN orders as o ON c.id = o.customer_id
JOIN order_items AS oi ON o.id = oi.order_id
JOIN products AS p ON oi.product_id = p.id
WHERE p.product_name = 'Fries';

INSERT INTO birds (name, age, species)
VALUES
  ('Charlie', 3, 'Finch'),
  ('Allie', 5, 'Owl'),
  ('Jennifer', 3, 'Magpie'),
  ('Jamie', 4, 'Owl'),
  ('Roy', 8, 'Crow');

  #◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

  CREATE TABLE airlines 
  (id SERIAL PRIMARY KEY),
  (airline_name VARCHAR(30) NOT NULL),
  (country_name VARCHAR(50)),
  (iata_code CHAR(2)),
  (icao_code CHAR(2)),
  (web_address VARCHAR(40));

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

  CREATE TABLE flights(
    id SERIAL PRIMARY KEY,
    flight_code VARCHAR(8) NOT NULL,
    Depart_Airport VARCHAR(40),
    Arrive_Airport VARCHAR(40),
    depart_date DATE,
    arrive_date DATE,
    depart_time TIMESTAMP,
    arrive_time TIMESTAMP
  )

  CREATE TABLE airline_id (
    id SERIAL PRIMARY KEY,
    flight_id INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES flights(id) ON DELETE CASCADE
  );

  Here we have a `flights` and `airline_id` tables, which to my mind form a one-to-one relationship because each airline_id is associated to a single flight. An airline id cannot have two flights and a flight cannot have more than one id. However, I noticed data from both an arriving and departing flight is stashed within the `flights` table. This means that `airline_id` actually points to more than one flight which would then turn it into a one-to-many relationship where we have one flight and many airline id''s. What do you think?


  #◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

  CREATE TABLE todos (
    id SERIAL PRIMARY KEY,
    todo_name VARCHAR(50),
  );

  ALTER TABLE todos
  ADD COLUMN todo_name TYPE NOT NULL;
  
#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

Specify all values and list them all.
INSERT INTO tools (name, cost, price, stock, discount, comments)
VALUES 
('Drill', 25, 35, 5, DEFAULT, NULL),
('Screw Driver', 5, 8, 2, DEFAULT, NULL);

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

INSERT INTO tools (name, cost, price, stock)
VALUES 
('Dill', 25, 35, 5),
('Screw Driver', 5, 8, 2);

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

SELECT dessert_name FROM dessets
WHERE dessert_name = 'Apple Pie';

SELECT dessert_name FROM dessets
WHERE id = 1;

SELECT dessert_name FROM dessets
ORDER BY id ASC LIMIT 1;

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

SELECT name FROM students
WHERE name = 'Aishwarya' OR name ='Clara';

SELECT name FROM students
ORDER BY name ASC LIMIT 2;

SELECT name FROM students
WHERE age <= 25

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

SELECT team, sum(score) AS team_score FROM player_scores
WHERE team = 'Red' OR team = 'Blue' OR team= 'Gold' GROUP BY team;


SQL is a Declarative language, meaning that unlike a general purpose language, which allows you to specify the implementation details for how to achieve something. Declarative languages abstract much of the HOW TO, allowing you to use english like syntax to describe what you want.


#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

Data Definition Language whic is responsible for inserting values into the structure or shcema of a database.

Data Management Language is reponsible for outlining the structure or shcema of a database

varchar allows for a variable number of characters specified as an argument. Text allows for unlimited characters.

Integer stores whole numbers, real floating-point numbers 

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

CREATE TABLE people (
  name VARCHAR(255),
  age INT,
  occupation VARCHAR(255)
);

INSERT INTO people
  VALUES
    ('Abby', 34, 'biologist'),
    ('Mu''nisah', 26, NULL),
    ('Mirabelle', 40, 'contractor');


SELECT * FROM people
WHERE name = 'Mu''nisah';

SELECT * FROM people
ORDER BY age LIMIT 1;

SELECT * FROM people
WHERE occupation IS NULL;

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

CREATE TABLE birds(
  name VARCHAR(255),
  length DECIMAL(4, 1),
  wingspan DECIMAL(4, 1),
  family VARCHAR(255),
  extinct BOOLEAN,
);

INSERT INTO birds
  VALUES
    ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', FALSE),
    ('American Robin', 25.5, 36.0, 'Turdidae', FALSE),
    ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', TRUE),
    ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', TRUE),
    ('Common Kestrel', 35.5, 73.5, 'Falconidae', FALSE);

SELECT name, length FROM birds
WHERE exict = TRUE
ORDER BY DESC length;

SELECT round(avg(wingspan)), min(wingspan), max(wingspan)  FROM birds;

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

CREATE TABLE menu_items(
  item VARCHAR(255),
  prep_time INT,
  ingredient_cost DECIMAL(6, 2),
  sales INT,
  menu_price DECIMAL(6, 2)
);

INSERT INTO menu_items
  VALUES
    ('omelette', 10, 1.50, 182, 7.99),
    ('tacos', 5, 2.00, 254,	8.99),
    ('oatmeal', 1, 0.50, 79, 5.99);

SELECT item, menu_price - ingredient_cost AS profit FROM menu_items
ORDER BY profit DESC LIMIT 1;

The most profitable item based on production time would be the one that is fastest to prepare and yields the greatest profit.

Identify total time invested for total sales

10min * 182 = 1820
1820 total time divided by 60 min = hours30
30hr * 13 = $390 paid in wages
cost of product = $273
difference = 273 + 390 = 
5min * 182 = 1270

SELECT item, menu_price, ingredient_cost,
    round(13.0 / 60, 2) * prep_time AS labor,
    menu_price - ingredient_cost - round(13.0 / 60, 2) * prep_time AS profit
  FROM menu_items
  ORDER BY profit DESC;

  The file DROP a table named `film` if one exists, otherwise a new `film` table is created with the following columns and data types (title varchar(50), year, genre). Then inserts the appropriate values

UPDATE films
  SET director = 'John McTiernan',
      duration = 132
  WHERE title = 'Die Hard';

UPDATE films
  SET director = 'Michael Curtize',
      duration = 102
  WHERE title = 'Casablanca';

UPDATE films
  SET director = 'Francis Ford Coppola',
      duration = 113
  WHERE title = 'The Conversation';

INSERT INTO films
  VALUES
    ('1984', 1956, 'scifi', 'Michael Anderson', 90),
    ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson',	127),
    ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 	118);

SELECT title, year FROM films
ORDER BY year DESC;

SELECT title, duration, FROM films
WHERE duration >= 120;

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

SELECT state, count(id) FROM people
GROUP BY state
ORDER BY count DESC LIMIT 10;


SELECT SUBSTRING(email FROM '@(.*)$') AS domain
  COUNT(id)
  FROM people
  GROUP BY domain
  ORDER BY count DESC;

  SELECT email AS domain 
    COUNT(id)
  FROM people;