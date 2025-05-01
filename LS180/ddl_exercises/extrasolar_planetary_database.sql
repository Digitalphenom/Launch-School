▣ Exercise 1

CREATE TABLE stars(
  id SERIAL PRIMARY KEY,
  name VARCHAR(25) UNIQUE NOT NULL,
  distance INT NOT NULL CHECK (distance > 0),
  spectral_type CHAR(1),
  companions INT NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets(
  id SERIAL PRIMARY KEY,
  designation CHAR(1) UNIQUE,
  mass INT
);

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

▣ Exercise 2

ALTER TABLE planets
ADD COLUMN star_id INT NOT NULL REFERENCES stars(id)

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

3. 

ALTER TABLE stars
ALTER COLUMN name TYPE VARCHAR(50);

-- Updating the datatype to `VARCHAR(50)` does not raise an error  because the existing values meet the specified constraint of 50 chars. If we attempt to update to `VARCHAR(5)` an error is raised.

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

4. 
ALTER TABLE stars
ALTER COLUMN distnace TYPE numeric

-- updating the data type of INT to numeric when an existing column references a whole number does not automatically convert it into its decimal equivalent i.e. `4 => 4.0`, unless it is manually specified with `decimal(2, 1)`.

-- The opposite is slightly different in that a decimal number `4.6` will auto round to 4. It's worth noting that this action is permanent so proceed with caution.