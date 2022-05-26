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
       CASE MIN(S1.claim_seq) WHEN 2 THEN 'AP'
                              WHEN 3 THEN 'OR'
                              WHEN 4 THEN 'SF'
                              ELSE 'CL' END
FROM (
  (
    Claims AS C1
    INNER JOIN Defendants AS D1 ON C1.claim_id = D1.claim_id
  ) CROSS JOIN ClaimStatusCodes AS S1
  LEFT OUTER JOIN LegalEvents AS E1 ON C1.claim_id = E1.claim_id
  AND D1.defendant_name = E1.defendant_name
  AND S1.claim_status = E1.claim_status
)
WHERE E1.claim_id IS NULL
GROUP BY C1.claim_id, C1.patient_name
;

