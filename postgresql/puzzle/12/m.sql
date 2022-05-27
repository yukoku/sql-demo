CREATE TABLE IF NOT EXISTS Claims
(
  claim_id INTEGER PRIMARY KEY NOT NULL,
  patient_name CHAR(10) NOT NULL
)
;

CREATE TABLE IF NOT EXISTS Defendants
(
  claim_id NOT NULL REFERENCES Claims(claim_id),
  defendant_name CHAR(10) NOT NULL
)
;

CREATE TABLE IF NOT EXISTS Defendants
(
  claim_id NOT NULL REFERENCES Claims(claim_id),
  defendant_name CHAR(10) NOT NULL
)
;

CREATE TABLE IF NOT EXISTS LegalEvents
(
  claim_id NOT NULL REFERENCES Claims(claim_id),
  defendant_name CHAR(10) NOT NULL,
  claim_status CHAR(2) NOT NULL
    CHECK(claim_status IN ('AP', 'OR', 'SF', 'CL')),
  change_date DATE NOT NULL
)
;


CREATE TABLE IF NOT EXISTS ClaimStatusCodes
(
  claim_status CHAR(2) NOT NULL
    CHECK(claim_status IN ('AP', 'OR', 'SF', 'CL')),
  claim_status_desc CHAR(30) NOT NULL,
  claim_seq INTEGER PRIMARY KEY NOT NULL
)
;

SELECT c.claim_id,
       c.patient_name,
       CASE MIN(code.claim_seq)
       WHEN 1 THEN 'AP'
       WHEN 2 THEN 'OR'
       WHEN 3 THEN 'SF'
       WHEN 4 THEN 'CL'
       ELSE
         NULL
       END
FROM
(
  SELECT le.claim_id AS claim_id,
         le.defendant_name AS defendant_name,
         MAX(code.claim_seq) AS max_claim_seq
  FROM LefalEvents le
  INNER JOIN ClaimStatusCodes code ON le.claim_status = code.claim_status
  GROUP BY le.claim_id, le.defendant_name
) tmp
INNER JOIN Claims c ON tmp.claim_id = c.claim_id
INNER JOIN ClaimStatusCodes code ON tmp.claim_seq = code.claim_seq
GROUP BY c.claim_id, c.patient_name
;


