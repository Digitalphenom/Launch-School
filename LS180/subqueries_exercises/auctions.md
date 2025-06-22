
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
### ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

6. Scalar Subqueries

```sql
SELECT items.name, COUNT(bids.item_id) FROM items
  LEFT OUTER JOIN bids ON bids.item_id = items.id
  GROUP BY items.name, items.id
  ORDER BY items.id;

-- OR

SELECT items.name, (
  SELECT COUNT(bids.item_id) FROM bids
  WHERE items.id = bids.item_id
  )
FROM items;

```

### ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

7. Row Comparison
return the id number for the item that matches "'Painting', 100.00, 250.00"

```sql
SELECT id FROM items
  WHERE 'Painting, 100.00, 250.00' =
  CONCAT_WS(', ', "name", initial_price, sales_price);

SELECT id FROM items
  WHERE ROW('Painting', 100.00, 250.00) = 
    ROW("name", initial_price, sales_price);

```

### ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

8. EXPLAIN

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

I used SELECT DISTINCT along with a LEFT OUTER JOIN and a WHERE condition.
Im seeing the following nodes and they're cost respectively.

  - a HashAggregate (total cost 29.63)
  - Hash Join
  - Seq Scan on bidders
  - Hash
  - Seq Scan on bids

  - Hash Semi Join (27.91)
  - Seq Scan on bidders
  - Hash
  - Seq Scan on bids

From what I understand the top most node is what I should be on the look out for. So for the first query that uses a `join` table the top node `HashAggregate` has a total cost of `29.37` and a node count of 4.

The second query uses `EXISTS` and is slightly less resource intensive with the top node `Hash Join` totaling in at `27.91` with only 3 nodes. However, the starting cost is significantly higher at `29.37` over `1.58` for the join table.

Im not sure what the ramifications of this seemingly, slight improvement is on a database, but based on the theory. The slight total cost improvement of the `EXISTS` table over the `JOIN` table is preferable especially on large databases. However, I don't know how the significantly higher starting cost's factors into the equation.

After using `ANALYZE` on both queries. It looks like the actual time is calculated in segmented loops, making it hard to compare the estimate vs actual time, unless I manually multiply the loop times. I think I need more context.

### ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

9. Comparing SQL Statements

```sql
EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
```
When running EXPLAIN ANALYZE on this query we get a total cost of 1.98 and an axtual run time of 0.072 for 1 row.
The planning time is 0.214m
The Execution time is 0.114m

```sql
EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;
```

This query gives a total cost of 1.78 and an actual run time of 0.268 for 1 row and loop.
The Planning time is 0.489m
The Execution time is 0.378m


Between the two queries, the one using a subquery with `MAX()` performs better both in planning and execution time.

This makes the subquery, slightly more efficient than the query without a subquery.
