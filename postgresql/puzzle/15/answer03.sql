CREATE TABLE IF NOT EXISTS Salaries
(
  emp_name CHAR(10) NOT NULL,
  sal_date DATE NOT NULL,
  sal_amt DECIMAL(8, 2) NOT NULL,
  PRIMARY KEY (emp_name, sal_date)
)
;

SELECT B.emp_name, B.maxdate, Y.sal_amt, B.maxdate2, Z.sal_amt
FROM (
  SELECT A.emp_name, A.maxdate, MAX(X.sal_date) AS maxdate2
  FROM (
    SELECT W.emp_name, MAX(W.sal_date) AS maxdate
    FROM Salaries AS W
    GROUP BY W.emp_name
  ) AS A
  LEFT OUTER JOIN Salaries AS X
  ON A.emp_name = X.emp_name
  AND A.maxdate > X.sal_date
  GROUP BY A.emp_name, A.maxdate
) AS B
LEFT OUTER JOIN Salaries AS Y
ON B.emp_name = Y.emp_name AND B.maxdate = Y.sal_date
LEFT OUTER JOIN Salaries AS Z
ON B.emp_name = Z.emp_name AND B.maxdate2 = Z.sal_date
;
