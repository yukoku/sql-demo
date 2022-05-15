CREATE TABLE IF NOT EXISTS Foobar
(
  no_alpha VARCHAR(6) NOT NULL
    CHECK (UPPER(no_alpha) = LOWER(no_alpha)),
  some_alpha VARCHAR(6) NOT NULL
    CHECK (UPPER(some_alpha) <> LOWER(some_alpha)),
  all_alpha VARCHAR(6) NOT NULL
    CHECK (UPPER(all_alpha) <> LOWER(all_alpha)
      AND SUBSTRING(LOWER(all_alpha) FROM 1 FOR 1)
          BETWEEN 'a' AND 'z'
      AND SUBSTRING(LOWER(all_alpha) FROM 2 FOR 1) || 'a'
          BETWEEN 'a' AND 'za'
      AND SUBSTRING(LOWER(all_alpha) FROM 3 FOR 1) || 'a'
          BETWEEN 'a' AND 'za'
      AND SUBSTRING(LOWER(all_alpha) FROM 4 FOR 1) || 'a'
          BETWEEN 'a' AND 'za'
      AND SUBSTRING(LOWER(all_alpha) FROM 5 FOR 1) || 'a'
          BETWEEN 'a' AND 'za'
      AND SUBSTRING(LOWER(all_alpha) FROM 6 FOR 1) || 'a'
          BETWEEN 'a' AND 'za'
    ),
)
;
