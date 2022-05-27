CREATE TABLE IF NOT EXISTS Projects
(
  workorder_id CHAR(5) NOT NULL,
  step_nbr INTEGER NOT NULL
    CHECK(step_nbr BETWEEN 0 AND 1000),
  step_status CHAR(1) NOT NULL
    CHECK(step_status IN ('C', 'W')),
  PRIMARY KEY (workorder_id, step_nbr)
)
;

SELECT workorder_id
FROM Projects
GROUP BY
HAVING SUM(
  CASE WHEN step_nbr <> 0 AND step_status = 'W' THEN 1
  WHEN step_nbr = 0 AND step_status = 'C' THEN 1
  ELSE 0 END
) = COUNT(step_nbr)
;

