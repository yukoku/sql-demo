CREATE TABLE IF NOT EXISTS PrinterControl
(
  user_id CHAR(10),
  printer_name CHAR(4) NOT NULL PRIMARY KEY,
  printer_description CHAR(40) NOT NULL
)
;

SELECT COALESCE(MIN(printer_name),(
    SELECT DISTINCT CASE WHEN :user_id < 'n' THEN 'LPT4' ELSE 'LPT5' END
    FROM PrinterControl
    WHERE user_id IS NULL
  )
) FROM PrinterControl
WHERE user_id = :user_id
;

