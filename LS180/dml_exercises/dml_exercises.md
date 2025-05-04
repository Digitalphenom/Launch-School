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
# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

10. UPDATE device_id

Our devices table contains parts that dont belong to "Gyroscope". Remove Gyros last two parts and place them in "Accelerometer".

My initial thinking was to drop the parts from the parts table and then re-insert them associated to the correct device_id. However, it looks like I can simply update those parts associated id the correct one without dropping them.

Algo/
Access part number 37 and 39, update its device_id to 1.

```sql
UPDATE parts SET device_id = 1
WHERE part_number = 37 OR part_number = 39;
```

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Further Exploration ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

What if we wanted to set the part with the smallest part_number to be associated with "Gyroscope"? How would we go about doing that?

If we wanted to update the part with the smallest `part_number` I would sort the table by `part_number` in ASC order, limit the table to the first row then apply the update on that row.

```sql
UPDATE parts SET device_id = 1
WHERE part_number = (
  SELECT part_number FROM parts
  WHERE device_id = 2
  ORDER BY part_number
  LIMIT 1);

-- The subquery executes first, which returns the smallest part_number on "Gyroscopes" device then the device_number is updated on that returned row.
```