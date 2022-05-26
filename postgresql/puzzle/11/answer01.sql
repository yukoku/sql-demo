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
FROM Projects AS P1
WHERE step_nbr = 0
AND step_status = 'C'
AND 'W' ALL (
  SELECT step_status
  FROM Projects AS P2
  WHERE step_nbr <> 0
  AND P1.workorder_id = P1.workorder_id
)
;
