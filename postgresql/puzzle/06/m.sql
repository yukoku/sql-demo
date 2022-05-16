-- postgresだとcheck制約でsubqueryは使えない
CREATE TABLE IF NOT EXISTS Hotel
(
  room_nbr INTEGER NOT NULL,
  arrival_date DATE NOT NULL,
  departure_date DATE NOT NULL,
  guest_name CHAR(30) NOT NULL,
  PRIMARY KEY (room_nbr, arrival_date),
  CHECK (departure_date >= arrival_date),
  CONSTRAINT valid_arrival_date
    CHECK (arrival_date >= ALL (
        SELECT departure_date
        FROM Hotel h
        WHERE h.room_nbr = room_nbr
      )
    )
)
;
