CREATE TABLE IF NOT EXISTS Salaries
(
  emp_name CHAR(10) NOT NULL,
  sal_date DATE NOT NULL,
  sal_amt DECIMAL(8, 2) NOT NULL,
  PRIMARY KEY (emp_name, sal_date)
)
;

-- 自分の回答にプラスしてUNION ALLで名前だけ持ってくる
SELECT S0.emp_name, S0.sal_date, S0.sal_amt, S1.sal_date, S1.sal_amt
FROM Salaries AS S0, Salaries AS S1
WHERE S0.emp_name = S1.emp_name
AND S0.sal_date (
  SELECT MAX(S2.sal_date)
  FROM Salaries AS S2
  WHERE S0.emp_name = S2.emp_name
) AND S1.sal_date = (
  SELECT MAX(S3.sal_date)
  FROM Salaries AS S3
  WHERE S0.emp_name = S3.emp_name
  AND S3.sal_date < S0.sal_date
)
UNION ALL
SELECT S4.emp_name, MAX(S4.sal_date), MAX(S4.sal_amt), NULL, NULL
FROM Salaries AS S4
GROUP BY S4.emp_name
HAVING COUNT(*) = 1
;
