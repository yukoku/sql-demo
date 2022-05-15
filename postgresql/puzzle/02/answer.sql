UPDATE Absenteeism AS A1
SET severity_points = 0,
    reason_code = 'long term illness'
WHERE EXISTS
(
  SELECT *
  FROM Absenteeism AS A2
  WHERE A1.emp_id = A2.emp_id
  AND (A2.absent_date + INTERVAL '1' DAY) = A1.absent_date)
);

DELETE FROM Personnel
WHERE emp_id = (
  SELECT A1.emp_id
  FROM Absenteeism AS A1
  AND absent_date BETWEEN CURRENT_TIMESTAMP - INTERVAL '1' YEAR AND CURRENT_TIMESTAMP
  GROUP BY A1.emp_id
  HAVING SUM(severity_points) >= 40
);
