CREATE TABLE IF NOT EXISTS Seats
(
  id INTEGER NOT NULL PRIMARY KEY
)
;


-- 番兵を用意する
INSERT INTO Seats VALUES (0);
INSERT INTO Seats VALUES (1001);
-- 使用中のテーブルはinsertされて空席は削除される

SELECT (S1.id + 1) AS start,
       (MIN(S2.id) - 1) AS finish
FROM Seats AS S1
INNER JOIN Seats AS S2 ON S2.id > S1.id
GROUP BY S1.id
HAVING (S1.id + 1) < MIN(S2.id)
;

-- OLAP ver
SELECT X.id,
       X.rn,
       (id - rn) AS available_seat_cnt
FROM (
  SELECT id,
         ROW_NUMBER() OVER (ORDER BY id)
  FROM Seats
) AS X(id, rn)
WHERE rn <> id
;
