CREATE TABLE IF NOT EXISTS Personnel
(
  emp_id INTEGER NOT NULL PRIMARY KEY,
  emp_name CHAR(30) NOT NULL
)
;

CREATE TABLE IF NOT EXISTS Badges
(
  badge_nbr INTEGER NOT NULL PRIMARY KEY,
  emp_id NOT NULL REFRENCES Personnel(emp_id),
  issued_date DATE NOT NULL,
  badge_status CHAR(1) NOT NULL
    CHECK(badge_status IN ('A', 'I')),
  CHECK(1 <= ALL (SELECT COUNT(badge_status)
      FROM Badges
      WHERE badge_status = 'A'
      GROUP BY emp_id))
)
;

UPDATE Badges
SET badge_status = 'A'
WHERE ('I' = ALL(SELECT badge_status
                 FROM Badges AS B1
                 WHERE Badges.emp_id = B1.emp_id))
AND (issued_date = (SELECT MAX(issued_date)
                    FROM Badges AS B2
                    WHERE Badges.emp_id = B2.emp_id))
;

SELECT p.emp_id,
       p.emp_name,
       b.badge_nbr
FROM Personnel p
LEFT OUTER JOIN Badges b
ON p.emp_id = b.emp_id
AND b.badge_status = 'A'
