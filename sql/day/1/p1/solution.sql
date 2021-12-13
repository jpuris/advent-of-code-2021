-- DDL
CREATE SCHEMA IF NOT EXISTS day_1;

DROP TABLE IF EXISTS day_1.input_part_1;

CREATE TABLE IF NOT EXISTS day_1.input_part_1
(
    num INT
);

-- DATA LOAD
COPY day_1.input_part_1 FROM '/day/1/p1/input.csv';

-- SOLUTION
WITH map AS (
    SELECT
        num > LAG(num) OVER () AS is_increase
    FROM day_1.input_part_1
            )

SELECT
    COUNT(*) FILTER ( WHERE is_increase ) AS answer
FROM map;