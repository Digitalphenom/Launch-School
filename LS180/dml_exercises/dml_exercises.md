1. Set Up Database

```sql
CREATE DATABASE workshop;

CREATE TABLE devices(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts(
  id SERIAL PRIMARY KEY,
  part_number INT UNIQUE NOT NULL,
  device_id INT REFERENCES devices(id)
);

```
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

3. Insert Data for Parts and Devices

Now that we have the infrastructure for our workshop set up, let's start adding in some data. Add in two different devices. One should be named, "Accelerometer". The other should be named, "Gyroscope".

```sql
INSERT INTO devices (name)
  VALUES
    ('Accelorometer'), ('Gyroscope');

```
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

4. INNER JOIN

```sql

SELECT d.name, p.part_number FROM devices d
INNER JOIN parts p ON p.device_id = d.id;

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

5. SELECT part_number

We want to grab all parts that have a part_number that starts with 3. Write a SELECT query to get this information. This table may show all attributes of the parts table.

```sql
SELECT * FROM parts
WHERE CAST(part_number AS TEXT) LIKE '3%';

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

6. Aggregate Functions

Write an SQL query that returns a result table with the name of each device in our database together with the number of parts for that device.

```sql
SELECT d.name, COUNT(p.device_id) FROM devices d
LEFT OUTER JOIN parts p ON d.id = p.device_id
GROUP BY d.name;

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

7. Order by

```sql
SELECT d.name, COUNT(p.device_id) FROM devices d
LEFT OUTER JOIN parts p ON d.id = p.device_id
GROUP BY d.name
ORDER BY name;

```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

8. NULLs

Write two SQL queries:
- One that generates a listing of parts that currently belong to a device.
- One that generates a listing of parts that don't belong to a device.

```sql
SELECT p.part_number, p.device_id FROM parts p
WHERE p.device_id IS NOT NULL;
```

```sql
SELECT p.part_number, p.device_id FROM parts p
WHERE p.device_id IS NULL;
```

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

9. Oldest Device
```sql
SELECT d.name || MIN(d.created_at)::TEXT FROM devices d
```

LS solution
```sql
SELECT d.name AS oldest_device FROM devices d
ORDER BY d.created_at ASC
LIMIT 1;
```

Manual approach that JOINs two device transient tables and based on the ON condition `a.created_at < b.created_at`, then filters NULLs and returns the remaining row.

```sql

SELECT a.* FROM devices a
LEFT JOIN devices b ON a.created_at < b.created_at
WHERE b.created_at IS NULL;

```