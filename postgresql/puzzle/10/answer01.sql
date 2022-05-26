CREATE TABLE IF NOT EXISTS Pensions
(
  sin CHAR(10) NOT NULL,
  pen_year INTEGER NOT NULL,
  month_cnt INTEGER DEFAULT 0 NOT NULL
    CHECK(month_cnt BETWEEN 0 AND 12),
  earnings DECIMAL(8, 2) DEFAULT 0.00 NOT NULL
)
;

CREATE VIEW IF NOT EXISTS PenPeriods (sin, start_year, end_year, earnings_tot)
SELECT P0.sin,
       P0.pen_year,
       P1.pen_year,
       (
         SELECT SUM(earnings)
         FROM Pensinons AS P2
         WHERE P2.sin = P0.sin
         AND P2.pen_year BETWEEN P0.pen_year
                         AND P1.pen_year
       )
FROM Pensions AS P0, Pensions AS P1
WHERE P1.sin = P0.sin
AND P1.pen_year >= (P0.pen_year - 4)
AND 0 < ALL (
  SELECT month_cnt
  FROM Pensions AS P3
  WHERE P3.sin = P0.sin
  AND P3.pen_year BETWEEN P0.pen_year
                  AND P1.pen_year
)
AND 60 <= (
  SELECT SUM(month_cnt)
  FROM Pensions AS P4
  WHERE P4.sin = P0.sin
  AND P3.pen_year BETWEEN P0.pen_year
                  AND P1.pen_year
)
;

SELECT * FROM PenPeriods AS P0
WHERE end_year = (
  SELECT MAX(end_year)
  FROM PenPeriods AS P1
  WHERE P1.sin = P0.sin
)
;
