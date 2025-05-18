
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

2. Conditional Subqueries: IN

```sql
SELECT DISTINCT i.name AS bid_on_items FROM items i
    LEFT OUTER JOIN bids ON bids.item_id = i.id
  WHERE bids.item_id IS NOT NULL;

-- ‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

SELECT DISTINCT i.name AS bid_on_items FROM items i
  WHERE i.id IN (SELECT DISTINCT item_id FROM bids);
  
```
#### ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

3. Conditional Subqueries: NOT IN

```sql
SELECT i.name AS "Not Bid On" FROM items i
  LEFT OUTER JOIN bids ON i.id = bids.item_id
  WHERE bids.item_id IS NULL;

  -- OR

SELECT i.name AS "Not Bid On" FROM items i
  WHERE i.id NOT IN (SELECT item_id FROM bids);
```

