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

SELECT C1.claim_id,
       C1.patient_name,
       S1.claim_status
FROM S1.claim_seq IN (
  SELECT MIN(S2.claim_seq)
  FROM ClaimStatusCodes AS S2
  WHERE S2.claim_seq IN (
    SELECT MAX(S3.claim_seq)
    FROM LegalEvents AS E1, ClaimStatusCodes AS S3
    WHERE E1.claim_status = S3.claim_status
    AND E1.claim_id = C1.claim_id
    GROUP BY E1.defendant_name
  )
)
;
