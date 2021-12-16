-- DDL
CREATE SCHEMA IF NOT EXISTS day_2;

DROP TABLE IF EXISTS day_2.input;

CREATE TABLE IF NOT EXISTS day_2.input
(
    command TEXT
);

-- DATA LOAD
COPY day_2.input FROM '/day/2/input.csv';

-- PART 1 SOLUTION
WITH df AS (
    SELECT
        SPLIT_PART(command, ' ', 1) AS direction,
        SPLIT_PART(command, ' ', 2) :: INT AS unit
    FROM day_2.input
           )

SELECT
        SUM(CASE
                WHEN direction = 'down' THEN unit
                WHEN direction = 'up' THEN unit * -1 END) *
        SUM(CASE WHEN direction = 'forward' THEN unit END) AS "Answer (day 2, part 1)"
FROM df;

-- PART 2 SOLUTION
WITH df AS (
    SELECT
        SPLIT_PART(command, ' ', 1) AS direction,
        SPLIT_PART(command, ' ', 2) :: INT AS unit
    FROM day_2.input
           ),

     aim_cte AS (
         SELECT *,
                SUM(CASE
                        WHEN direction = 'down' THEN unit
                        WHEN direction = 'up' THEN unit * -1 END) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS aim
         FROM df
                )

SELECT
    SUM(unit) * SUM(aim * unit) AS "Answer (day 2, part 2)"
FROM aim_cte
WHERE direction = 'forward';