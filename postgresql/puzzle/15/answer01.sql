CREATE TABLE IF NOT EXISTS Salaries
(
  emp_name CHAR(10) NOT NULL,
  sal_date DATE NOT NULL,
  sal_amt DECIMAL(8, 2) NOT NULL,
  PRIMARY KEY (emp_name, sal_date)
)
;

-- SQLで完結しない前提
-- ずるい...
CREATE VIEW Salaries2(emp_name, sal_date, sal_amt)
AS SELECT S0.emp_name, S0.sal_date, MAX(S0.sal_amt)
FROM Salaries AS S0, Salaries AS S1
WHERE S0.sal_date <= S1.sal_date
AND S0.emp_name = S1.emp_name
GROUP BY S0.emp_name, S0.sal_date
HAVING COUNT(*) <= 2
;
