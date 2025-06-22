 1.

```sql
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
```

----

2.

```sql
ALTER TABLE planets
ADD COLUMN star_id INT NOT NULL REFERENCES stars(id)
```

----

3. 

```sql
ALTER TABLE stars
ALTER COLUMN name TYPE VARCHAR(50);
```
Updating the datatype to `VARCHAR(50)` does not raise an error  because the existing values meet the specified constraint of 50 chars. If we attempt to update to `VARCHAR(5)` an error is raised.

----

4. 

```sql
ALTER TABLE stars
ALTER COLUMN distnace TYPE numeric
```
-- updating the data type of INT to numeric when an existing column references a whole number does not automatically convert it into its decimal equivalent i.e. `4 => 4.0`, unless it is manually specified with `decimal(2, 1)`.

-- The opposite is slightly different in that a decimal number `4.6` will auto round to 4. It's worth noting that this action is permanent so proceed with caution.

----

5.  Add a constraint to ensure 'O', 'B', 'A', 'F', 'G', 'K', and 'M'are included.

```sql
ALTER TABLE stars
ADD CONSTRAINT check_type CHECK (spectral_type SIMILAR TO '%(O|B|A|F|G|K|M)%');
```
-----

⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Further Exploration ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

The further exploration problem arises from realising that the current data now requires a new set of constraints, not null and checking for invalid values i.e 'X'. However, how to add such constraints to an existing database that already contains "bad" values?

Well, one option could be to make a backup table, delete all of the existing data then modify the schema so it adds a `NOT NULL` constraint with a `DEFAULT` value of 'N/A' when values fields are empty and 'INVALID' when an invalid char is encountered, then reinsert all of the data.

This wouldnt work because the `spectral_type` data type is `CHAR(1)`, which only allows single char values. Another option could be to use "reserved" single chars to identify a column that contains a null value or invalid value. So rather than delete the existing data and then modifying the schema. The existing database could be cleaned for null and invalid chars, then the schema level changes would be applied to enforce the new constraints moving forward.

A simpler, more immediate option would be to use `NOT VALID` with `CHECK` to temporarily avoid existing data that does not conform to the specified constraint. Then perform whatever cleaning on the existing data.

----

6. Enumerated Types

```sql
ALTER TABLE stars
DROP CONSTRAINT check_type

CREATE TYPE valid_types AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ADD CONSTRAINT valid_types;

ALTER COLUMN spectral_type TYPE valid_types;
```
----

7. Planetary Mass Precision

Modify the mass column in the planets table so that it allows fractional masses to any degree of precision required. In addition, make sure the mass is required and positive. While we're at it, also make the designation column required.

```sql
ALTER TABLE planets
ALTER COLUMN mass TYPE DECIMAL,
ADD CONSTRAINT ensure_positive CHECK (mass >= 0),
ALTER COLUMN mass SET NOT NULL,
ALTER COLUMN designation SET NOT NULL;
```

----

8. Add a Semi-Major Axis Column

```sql
ALTER TABLE planets
ADD COLUMN semi_major_axis NUMERIC NOT NULL;
```
⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Further Exploration ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

This problem is similar to an earlier problem where a constraint is added to an existing column, but the data entered fails to meet the constraints requirements. This problem requires that we add a new column with a `NOT NULL` constraint. The problem is we are doing so on exisitng data, which raises an error because the new column value would initially be `NULL` since we have yet to add data to that particular column.

One way around this would be to set a `DEFAULT` value of 0 to each new column, since the smallest axis will likely be greater than 0.

This works, but fails because it allows `NOT NULL` values for every existing row. Another option would be to add the column, without the `NOT NULL` constriant. Populate the data, then add the `NOT NULL` constraint. 


ALTER TABLE planets
ADD COLUMN semi_major_axis NUMERIC;

----

9. For this exercise, your task is to add that table to the database. The table should include the following data:


```sql
CREATE TABLE moons(
  id SERIAL PRIMARY KEY,
  designation INT NOT NULL,
  semi_major_axis DECIMAL CHECK (semi_major_axis > 0.0),
  mass DECIMAL CHECK (mass > 0.0),
  planet_id INT NOT NULL REFERENCES planets(id);
);
```