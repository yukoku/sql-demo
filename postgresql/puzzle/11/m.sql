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

INSERT INTO Projects VALUES('AA100', 0, 'C');
INSERT INTO Projects VALUES('AA100', 1, 'W');
INSERT INTO Projects VALUES('AA100', 2, 'W');
INSERT INTO Projects VALUES('AA200', 0, 'W');
INSERT INTO Projects VALUES('AA200', 1, 'W');
INSERT INTO Projects VALUES('AA300', 0, 'C');
INSERT INTO Projects VALUES('AA300', 1, 'C');

SELECT p1.workorder_id
FROM Projects p1
LEFT OUTER JOIN Projects p2 ON p1.workorder_id = p2.workorder_id
WHERE p1.step_nbr = 0
AND p1.step_status = 'C'
GROUP BY p1.workorder_id
HAVING COUNT(p2.step_status = 'C' OR NULL) = 1
;
