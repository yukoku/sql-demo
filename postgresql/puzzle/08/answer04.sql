CREATE TABLE IF NOT EXISTS PrinterControl
(
  user_id CHAR(10),
  printer_name CHAR(4) NOT NULL PRIMARY KEY,
  assignable_flag CHAR(1) DEFAULT 'Y' NOT NULL
    CHACK(assignable_flag IN ('Y', 'N')),
  printer_description CHAR(40) NOT NULL
)
;

UPDATE PrinterControl
SET user_id = :guest_id
WHERE printer_name = (
  SELECT MIN(printer_name)
  FROM PrinterControl
  WHERE assignable_flag = 'Y'
  AND user_id IS NULL
)
;

UPDATE PrinterControl
SET user_id = NULL
WHERE assignable_flag = 'Y'
;
