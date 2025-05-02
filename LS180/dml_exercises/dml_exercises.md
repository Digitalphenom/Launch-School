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