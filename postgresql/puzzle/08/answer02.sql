CREATE TABLE IF NOT EXISTS PrinterControl
(
  user_id CHAR(10),
  printer_name CHAR(4) NOT NULL PRIMARY KEY,
  printer_description CHAR(40) NOT NULL
)
;

SELECT COALESCE(MIN(printer_name),(
    SELECT MIN(printer_name)
    FROM PrinterControl AS P2
    WHERE user_id IS NULL
  )
) FROM PrinterControl AS P1
WHERE user_id = :user_id
;
