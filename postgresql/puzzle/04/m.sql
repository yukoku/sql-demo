-- 問題文が不親切過ぎたので答えの流れだけ見た
CREATE TABLE IF NOT EXISTS Personnel
(
  emp_id INTEGER NOT NULL PRIMARY KEY,
  name CHAR(40) NOT NULL
)
;

CREATE TABLE IF NOT EXISTS Badges
(
  badge_nbr INTEGER NOT NULL PRIMARY KEY,
  emp_id NOT NULL REFRENCES Personnel(emp_id),
  issued_date DATE NOT NULL,
  badge_status CHAR(1),
  CONSTRAINT validate_badge_status
    CHECK(badge_status IN ('A', 'I'))
)
;

WITH latest_badge AS (
  SELECT emp_id,
         MAX(issued_date)
  FROM Badges b
  GROUP BY emp_id
) lb(emp_id, issued_date)
UPDATE Badges b
SET badge_status = CASE WHEN lb.emp_id = b.emp_id AND lb.issued_date = b.issued_date
                        THEN
                          'A'
                        ELSE
                          'I'
                        END
;

SELECT p.emp_id,
       b.badge_nbr
FROM Personnel p
LEFT OUTER JOIN Badges b
ON p.emp_id = b.emp_id
AND badge_status = 'A'
