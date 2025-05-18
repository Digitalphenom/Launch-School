
1. Set up database and data

```sql
CREATE DATABASE auction

CREATE TABLE bidders(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  initial_price DECIMAL(6,2) NOT NULL CHECK (initial_price BETWEEN 01.00 AND 1000.00),
  sales_price DECIMAL(6,2) CHECK (sales_price BETWEEN 01.00 AND 1000.00)
);


CREATE TABLE bids(
  id SERIAL PRIMARY KEY,
  bidder_id INT NOT NULL,
  item_id INT NOT NULL,
  amount DECIMAL(6,2) NOT NULL CHECK (amount BETWEEN 01.00 AND 1000.00),
  FOREIGN KEY (bidder_id) REFERENCES bidders(id) ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);
```
#### ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞



