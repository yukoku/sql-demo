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
WHERE step_status = 'C'
GROUP BY workorder_id
HAVING SUM(step_nbr) = 0
;
