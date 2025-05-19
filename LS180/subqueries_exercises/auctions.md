
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

### ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

4. Conditional Subqueries: EXISTS

```sql

SELECT DISTINCT b.name FROM bidders b
  LEFT OUTER JOIN bids ON bids.bidder_id = b.id
  WHERE bids.bidder_id IS NOT NULL;

-- ‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

SELECT b.name FROM bidders b
  WHERE EXISTS (
    SELECT 1 FROM bids
      WHERE bids.bidder_id = b.id
    );

```
### ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

5. Query From a Transient Table

The first thing to do is to return a table that contains all bidders and theyre associated bids. Then use this table to determine the greatest count from the outer query.

```sql
  SELECT MAX(inner_table.count) FROM 
  ( SELECT b.name, COUNT(bids.item_id) FROM bidders b
  LEFT OUTER JOIN bids ON bids.item_id = b.id
  GROUP BY b.name
  ORDER BY COUNT(bids.item_id) DESC) AS inner_table;

-- OR

  SELECT MAX(inner_table.count) FROM (
    SELECT COUNT(b.bidder_id) FROM bids b
    GROUP BY b.bidder_id
  ) AS inner_table;
```
