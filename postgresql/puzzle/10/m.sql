CREATE TABLE IF NOT EXISTS Pensions
(
  sin CHAR(10) NOT NULL,
  pen_year INTEGER NOT NULL,
  month_cnt INTEGER DEFAULT 0 NOT NULL
    CHECK (month_cnt BETWEEN 0 AND 12),
  earnings DECIMAL(8, 2) DEFAULT 0.00 NOT NULL
)
;

SELECT sin,
       SUM(earnings)
FROM Pensions p
WHERE p.pen_year IN (
  SELECT p2.pen_year
  FROM Pensions p2
  WHERE p.sin = p2.sin
  AND p2.pen_year * p2.month_cnt
)
GROUP BY sin
HAVING SUM(p2.pen_year * p2.month_cnt)

;

