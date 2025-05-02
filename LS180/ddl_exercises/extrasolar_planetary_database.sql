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

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

-- 5.  Add a constraint to ensure 'O', 'B', 'A', 'F', 'G', 'K', and 'M'are included.

ALTER TABLE stars
ADD CONSTRAINT check_type CHECK (spectral_type SIMILAR TO '%(O|B|A|F|G|K|M)%');

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Further Exploration ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

The further exploration problem arises from realising that the current data now requires a new set of constraints, not null and checking for invalid values i.e 'X'. However, how to add such constraints to an existing database that already contains "bad" values?

Well, one option could be to make a backup table, delete all of the existing data then modify the schema so it adds a `NOT NULL` constraint with a `DEFAULT` value of 'N/A' when values fields are empty and 'INVALID' when an invalid char is encountered, then reinsert all of the data.

This wouldnt work because the `spectral_type` data type is `CHAR(1)`, which only allows single char values. Another option could be to use "reserved" single chars to identify a column that contains a null value or invalid value. So rather than delete the existing data and then modifying the schema. The existing database could be cleaned for null and invalid chars, then the schema level changes would be applied to enforce the new constraints moving forward.

A simpler, more immediate option would be to use `NOT VALID` with `CHECK` to temporarily avoid existing data that does not conform to the specified constraint. Then perform whatever cleaning on the existing data.

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

6. Enumerated Types

ALTER TABLE stars
DROP CONSTRAINT check_type

CREATE TYPE valid_types AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ADD CONSTRAINT valid_types;

ALTER COLUMN spectral_type TYPE valid_types;