-- write queries here

CREATE USER denormal_user;

DROP DATABASE IF EXISTS denormal_cars;

CREATE DATABASE denormal_cars WITH OWNER denormal_user;

\c denormal_cars

\i scripts/denormal_data.sql

-- denormal_cars=# \dS car_models
--             Table "public.car_models"
--    Column    |          Type          | Modifiers
-- -------------+------------------------+-----------
--  make_code   | character varying(125) | not null
--  make_title  | character varying(125) | not null
--  model_code  | character varying(125) | not null
--  model_title | character varying(125) | not null
--  year        | integer                | not null

--  make_code |  make_title   |     model_code      |                model_title                | year
-- -----------+---------------+---------------------+-------------------------------------------+------
--  ACURA     | Acura         | CL_MODELS           | CL Models (4)                             | 2000
--  ACURA     | Acura         | CL_MODELS           | CL Models (4)                             | 2001
--  ACURA     | Acura         | CL_MODELS           | CL Models (4)                             | 2002
--  ACURA     | Acura         | CL_MODELS           | CL Models (4)                             | 2003


-- 5. In denormal_cars.sql Create a query to get a list of all make_title values in the car_models table. Without any duplicate rows, this should have 71 results.

SELECT DISTINCT make_title FROM car_models;

-- 6. In denormal_cars.sql Create a query to list all model_title values where the make_code is 'VOLKS'. Without any duplicate rows, this should have 27 results.

SELECT DISTINCT model_title
FROM car_models
WHERE make_code = 'VOLKS';

-- 7. In denormal_cars.sql Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM', Without any duplicate rows, this should have 136 rows.

SELECT DISTINCT model_title, make_code, model_code, year
FROM car_models
WHERE make_code = 'LAM';

-- 8. In denormal_cars.sql Create a query to list all fields from all car_models in years between 2010 and 2015. Without any duplicate rows, this should have 7884 rows.

SELECT DISTINCT *
FROM car_models
WHERE year BETWEEN 2010 AND 2015;

