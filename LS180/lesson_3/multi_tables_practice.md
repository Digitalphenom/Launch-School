
2. Write a query that determines how many tickets have been sold.

```sql
SELECT COUNT(id) FROM tickets;
```

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

4. Write a query that determines how many different customers purchased tickets to at least one event.

```sql

SELECT ROUND((COUNT(DISTINCT tickets.customer_id)::decimal / COUNT(customers.id) * 100), 2 )
FROM customers
LEFT JOIN tickets
ON tickets.customer_id = customers.id;

```

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

5. Write a query that returns the name of each event and how many tickets were sold for it, in order from most popular to least popular.


```sql

SELECT name, COUNT(event_id) AS popularity FROM tickets
  LEFT JOIN events
    ON events.id = tickets.event_id;
    GROUP BY event.id
    ORDER BY popularity DESC;

```

post 7f73baa0

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


6. Write a query that returns the user id, email address, and number of events for all customers that have purchased tickets to three events.


```sql

SELECT 
  c.id, c.email,
  COUNT(DISTINCT tickets.event_id)
FROM tickets t
INNER JOIN customers c ON t.customer_id = c.id
GROUP BY c.id
HAVING COUNT(DISTINCT t.event_id) = 3;

```
 
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

7. Write a query to print out a report of all tickets purchased by the customer with the email address 'gennaro.rath@mcdermott.co'. The report should include the event name and starts_at and the seat's section name, row, and seat number.

```sql

SELECT 
  e.name AS event,
  e.starts_at,
  sec.name AS section, 
  s.row, s.number AS seat
FROM tickets t
LEFT OUTER JOIN events e ON e.id = t.event_id
LEFT OUTER JOIN seats s ON s.id = t.seat_id
LEFT OUTER JOIN sections sec ON sec.id = s.section_id
LEFT OUTER JOIN customers c ON c.id = t.customer_id
WHERE c.email = 'gennaro.rath@mcdermott.co';

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

8. Use the events table to identify a user via its customer_id. The event attended via event_id and the customer id by associating the customer_id to the table containing emails

Get the total price for each customers ticket purchases. List the name and total price

```sql

SELECT 
  c.id, c.first_name, c.last_name, c.email,
  COUNT(events.base_price) AS total_spent
FROM tickets
JOIN customers c ON c.id = tickets.customer_id
JOIN events ON events.id = tickets.event_id
GROUP BY c.first_name
ORDER BY c.first_name;

```