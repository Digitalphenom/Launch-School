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
