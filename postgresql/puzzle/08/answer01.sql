CREATE TABLE IF NOT EXISTS PrinterControl
(
  user_id_start CHAR(10) NOT NULL,
  user_id_finish CHAR(10) NOT NULL,
  printer_name CHAR(4) NOT NULL,
  printer_description CHAR(40) NOT NULL
  PRIMARY KEY (user_id_start, user_id_finish)
)
;

SELECT MIN(printer_name)
FROM PrinterControl
WHERE :my_id BETWEEN user_id_start AND user_id_finish
;

