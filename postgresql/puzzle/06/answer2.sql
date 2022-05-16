CREATE TABLE IF NOT EXISTS Hotel
(
  room_nbr INTEGER NOT NULL,
  occupy_date DATE NOT NULL,
  guest_name CHAR(30) NOT NULL,
  PRIMARY KEY (room_nbr, occupy_date, guest_name)
)
;
