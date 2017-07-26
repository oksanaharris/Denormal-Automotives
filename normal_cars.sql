-- Normalized Table
-- 5. In normal_cars.sql Create a query to generate the tables needed to accomplish your normalized schema, including any primary and foreign key constraints. Logical renaming of columns is allowed.

\c normal_cars

DROP TABLE IF EXISTS model_years;
DROP TABLE IF EXISTS years;
DROP TABLE IF EXISTS models;
DROP TABLE IF EXISTS makes;

CREATE TABLE makes(
  id SERIAL PRIMARY KEY NOT NULL,
  make_code VARCHAR(125) NOT NULL,
  make_title VARCHAR(125) NOT NULL
);

CREATE TABLE models(
  id SERIAL PRIMARY KEY NOT NULL,
  model_code VARCHAR(125) NOT NULL,
  model_title VARCHAR(125) NOT NULL,
  makes_id INT REFERENCES makes(id) NOT NULL
);

CREATE TABLE years(
  id SERIAL PRIMARY KEY NOT NULL,
  year INT NOT NULL
);

CREATE TABLE model_years(
  id SERIAL PRIMARY KEY NOT NULL,
  models_id INT REFERENCES models(id) NOT NULL,
  years_id INT REFERENCES years(id) NOT NULL
);

\i scripts/denormal_data.sql
-- inserts 22338 records


INSERT INTO makes (make_code, make_title)  (
  SELECT DISTINCT make_code, make_title
  FROM car_models
  ORDER BY make_code
);
-- 71 rows


INSERT INTO models (model_code, model_title, makes_id) (
  SELECT DISTINCT old.model_code, old.model_title, makes.id
  FROM car_models old
  JOIN makes
  ON makes.make_code = old.make_code
  ORDER BY old.model_code
);
-- 1314 rows


INSERT INTO years (year) (
  SELECT DISTINCT year
  FROM car_models
  ORDER BY year
);
-- 17 rows


INSERT INTO model_years (models_id, years_id) (
  SELECT DISTINCT models.id, years.id
  FROM car_models old
  JOIN models
  ON old.model_code = models.model_code
  JOIN years
  ON old.year = years.year
  ORDER BY models.id
);
-- 22338 records


-- 7. In normal_cars.sql Create a query to get a list of all make_title values in the car_models table. Without any duplicate rows, this should have 71 results.

SELECT make_title
FROM makes;


-- 8. In normal_cars.sql Create a query to list all model_title values where the make_code is 'VOLKS' Without any duplicate rows, this should have 27 results.

SELECT model_title
FROM models
JOIN makes
ON makes.id = models.makes_id
WHERE makes.make_code = 'VOLKS';


-- 9. In normal_cars.sql Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM'. Without any duplicate rows, this should have 136 rows.

SELECT makes.make_code, models.model_code, models.model_title, years.year
FROM model_years m_y
JOIN models
ON m_y.models_id = models.id
JOIN years
ON m_y.years_id = years.id
JOIN makes
ON models.makes_id = makes.id
WHERE make_code = 'LAM';


-- 10. In normal_cars.sql Create a query to list all fields from all car_models in years between 2010 and 2015. Without any duplicate rows, this should have 7884 rows.
-- all fields being make_code, make_title, model_code, model_title, and year

SELECT makes.make_code, makes.make_title, models.model_code, models.model_title, years.year
FROM model_years m_y
JOIN models
ON m_y.models_id = models.id
JOIN years
ON m_y.years_id = years.id
JOIN makes
ON models.makes_id = makes.id
WHERE years.year BETWEEN 2010 AND 2015;
