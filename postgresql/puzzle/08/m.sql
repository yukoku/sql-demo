CREATE TABLE IF NOT EXISTS PrinterControl
(
  user_id CHAR(10),
  printer_name CHAR(4) NOT NULL PRIMARY KEY,
  printer_description CHAR(40) NOT NULL
)
;

SELECT printer_name
FROM PrinterControl
WHERE user_id = :specified_user_id_or_null OR user_id IS NULL
ORDER BY user_id DESC NULLS LAST
LIMIT 1
;
