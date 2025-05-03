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
