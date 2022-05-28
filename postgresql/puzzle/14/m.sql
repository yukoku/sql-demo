CREATE TABLE IF NOT EXISTS Personnel
(
  emp_id INTEGER PRIMARY KEY,
  first_name CHAR(20) NOT NULL,
  last_name CHAR(20) NOT NULL
)
;

CREATE TABLE IF NOT EXISTS Phones
(
  emp_id INTEGER NOT NULL,
  phone_type CHAR(3) NOT NULL
    CHECK (phone_type IN ('hom', 'fax')),
  phone_nber CHAR(12) NOT NULL,
  PRIMARY KEY (emp_id, phone_type),
  FOREIGN KEY (emp_id) REFERENCES Personnel(emp_id)
)
;

-- 答えその2と大体同じ
SELECT pe.emp_id,
       pe.first_name,
       pe.last_name,
       phh.phone_nbr AS hom_nbr,
       phf.phone_nbr AS fax_nbr
FROM Personnel pe
LEFT OUTER JOIN Phones phh ON phh.emp_id = pe.emp_id
AND phone_type = 'hom'
LEFT OUTER JOIN Phones phf ON phf.emp_id = pe.emp_id
AND phone_type = 'fax'
;
