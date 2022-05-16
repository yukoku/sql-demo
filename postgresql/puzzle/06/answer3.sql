CREATE TABLE IF NOT EXISTS Hotel
(
  room_nbr INTEGER NOT NULL,
  arrival_date DATE NOT NULL,
  departure_date DATE NOT NULL,
  guest_name CHAR(30) NOT NULL,
  PRIMARY KEY (room_nbr, arrival_date),
  CHECK (departure_date >= arrival_date)
)
;

CREATE VIEW HotelStays
(room_nbr, arrival_date, departure_date, guest_name) AS
SELECT room_nbr,
       arrival_date,
      departure_date,
      guest_name
FROM Hotel AS H1
WHERE NOT EXISTS (
  SELECT *
  FROM Hotel AS H2
  WHERE H1.room_nbr = H2.room_nbr
  AND H2.arrival_date < H1.arrival_date
  AND H1.arrival_date < H2.departure_date
)
WITH CHECK OPTION
;
