DELETE FROM Personnel
WHERE emp_id IN (
  SELECT emp_id FROM Absenteeism
  GROUP BY EXTRACT(YEAR FROM absent_date)
  HAVING SUM(severity_points) >= 40
)
;
