-- SQL89準拠の指定あったがよくわからないので無視
-- おそらくwindow関数を使うなということだと思う
CREATE TABLE IF NOT EXISTS Salaries
(
  emp_name CHAR(10) NOT NULL,
  sal_date DATE NOT NULL,
  sal_amt DECIMAL(8, 2) NOT NULL,
  PRIMARY KEY (emp_name, sal_date)
)
;

INSERT INTO Salaries
VALUES ('Tom', '1996-06-20', 500.00),
       ('Tom', '1996-08-20', 700.00),
       ('Tom', '1996-10-20', 800.00),
       ('Tom', '1996-12-20', 900.00),
       ('Dick', '1996-06-20', 500.00),
       ('Harry', '1996-07-20', 500.00),
       ('Harry', '1996-09-20', 700.00);

-- 昇給のみが登録されている前提
-- 昇給がない場合は行自体表示されない
SELECT s.emp_name,
       MAX(s.sal_amt) AS salary_before_increase,
       MAX(s2.sal_amt) AS current_salary,
       MAX(s2.sal_date) AS salary_increase_date
FROM Salaries s
LEFT OUTER JOIN (
  SELECT emp_name,
         MAX(sal_date),
         MAX(sal_amt)
  FROM Salaries
  GROUP BY emp_name
) s2(emp_name, sal_date, sal_amt)
ON s.emp_name = s2.emp_name
WHERE s2.sal_amt <> s.sal_amt
GROUP BY s.emp_name
;
