CREATE TABLE IF NOT EXISTS Personnel
(
  emp_id INTEGER NOT NULL PRIMARY KEY,
  emp_name CHAR(30) NOT NULL
)
;

CREATE TABLE IF EXISTS Badges
(
  badge_nbr INTEGER NOT NULL PRIMARY KEY,
  emp_id INTEGER NOT NULL PREFERENCES Personnel(emp_id),
  issued_date DATE NOT NULL,
  badge_seq INTEGER NOT NULL CHECK(badge_seq > 0),
  UNIQUE (emp_id, badge_seq)
)
;

CREATE VIEW ActiveBadges (emp_id, badge_nbr)
AS SELECT emp_id, badge_nbr
   FROM Badges AS B1
   WHERE badge_seq = (SELECT MAX(badge_seq)
                      FROM Badges AS B2
                      WHERE B1.emp_id = B2.emp_id
  )
;

UPDATE Badges
SET badge_seq = (SELECT COUNT(*)
  FROM Badges AS B1
  WHERE Badges.emp_id = B1.emp_id
  AND Badges.badge_seq >= B1.badge_seq
)
;
