CREATE TABLE IF NOT EXISTS FiscalYearTable1
(
  fiscal_year INTEGER UNIQUE NOT NULL,
  start_date DATE NOT NULL CHECK(
    -- start_dateが年始の場合はfiscal_yearと同じ年度であること
    CASE WHEN EXTRACT(YEAR FROM start_date) = EXTRACT(YEAR FROM end_date) THEN
      EXTRACT(YEAR FROM start_date) = fiscal_year
    -- start_dateが年始でない場合はfiscal_year-1年度であること(米国会計年度)
    WHEN EXTRACT(YEAR FROM start_date) = EXTRACT(YEAR FROM end_date) - 1 THEN
      EXTRACT(YEAR FROM start_date) = fiscal_year - 1
    ELSE
      FALSE
    END
    AND
    -- start_dateとend_dateが一日と一年違いであること
    end_date + CAST('1 day' as INTERVAL) = start_date + CAST('1 year' as INTERVAL)
    AND
    -- start_dateが月初であること
    EXTRACT(DAY FROM start_date) = 1
  ),
  end_date DATE NOT NULL
);
