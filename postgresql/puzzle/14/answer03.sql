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


SELECT E1.emp_id,
       E1.first_name,
       E1.last_name,
       MAX(CASE WHEN P1.phone_type = 'hom' THEN P1.phone_nbr ELSE NULL END) AS home_phone,
       MAX(CASE WHEN P1.phone_type = 'fax' THEN P1.phone_nbr ELSE NULL END) AS fax_phone
FROM Personnel AS E1
LEFT OUTER JOIN Phones AS P1
ON P1.emp_id = E1.emp_id
GROUP BY E1.emp_id, E1.first_name, E1.last_name
;
