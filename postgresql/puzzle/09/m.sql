CREATE TABLE IF NOT EXISTS Seats
(
  id INTEGER NOT NULL PRIMARY KEY
)
;

CREATE TABLE IF NOT EXISTS OccupiedSeats
(
  seat_id INTEGER NOT NULL REFERENCES Seats(id)
)
;

-- 空席照会
SELECT s.id
FROM Seats s
WHERE NOT EXISTS (
  SELECT 1
  FROM OccupiedSeats o
  WHERE s.id = o.seat_id
)
;
