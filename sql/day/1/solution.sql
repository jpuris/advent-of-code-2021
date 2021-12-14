-- DDL
CREATE SCHEMA IF NOT EXISTS day_1;

DROP TABLE IF EXISTS day_1.input;

CREATE TABLE IF NOT EXISTS day_1.input
(
    num INT
);

-- DATA LOAD
COPY day_1.input FROM '/day/1/input.csv';

-- PART 1 SOLUTION
WITH map AS (
    SELECT
        num > LAG(num) OVER () AS is_increase
    FROM day_1.input
            )

SELECT
    COUNT(*) FILTER ( WHERE is_increase ) AS "Answer (part 1)"
FROM map;

-- PART 2 SOLUTION
WITH sum_3_days_cte AS (
    SELECT
        num + LAG(num, 1) OVER () + LAG(num, 2) OVER () AS _sum
    FROM day_1.input
                       ),
     check_cte AS (
         SELECT
             _sum > LAG(_sum) OVER () AS is_increase
         FROM sum_3_days_cte
                  )

SELECT
    COUNT(*) FILTER ( WHERE is_increase ) AS "Answer (part 2)"
FROM check_cte;