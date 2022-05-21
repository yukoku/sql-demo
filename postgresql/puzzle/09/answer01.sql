CREATE TABLE IF NOT EXISTS Seats
(
  id INTEGER NOT NULL PRIMARY KEY
)
;

UPDATE Seats
SET id = -id
WHERE id = :my_seat_id
;
