CREATE TABLE FiscalYearTable1
(
  fiscal_year INTEGER NOT NULL PRIMARY KEY,
  start_date DATE NOT NULL,
  CONSTRAINT valid_start_date
    CHECK(
      (EXTRACT(MONTH FROM start_date) = fiscal_year - 1)
      AND (EXTRACT(MONTH FROM start_date) = 10)
      AND (EXTRACT(DAY FROM start_date) = 1)
    )
  end_date DATE NOT NULL,
  CONSTRAINT valid_end_date
    CHECK(
      (EXTRACT(MONTH FROM end_date) = fiscal_year)
      AND (EXTRACT(MONTH FROM start_date) = 9)
      AND (EXTRACT(DAY FROM start_date) = 30)
    )
);
