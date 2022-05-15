CREATE TABLE IF NOT EXISTS Alphabet
(
  str_only_alphabet CHAR(40) NOT NULL,
  str_only_1_alphabet CHAR(40) NOT NULL,
  str_none_alphabet CHAR(40) NOT NULL,
  CONSTRAINT valid_str_only_alphabet
    CHECK(regexp_matches(str_only_alphabet, '^[a-zA-Z]+$')),
  CONSTRAINT valid_str_1_alphabet
    CHECK(regexp_matches(str_only_1_alphabet, '^[a-zA-Z]$')),
  CONSTRAINT valid_str_none_alphabet
    CHECK(regexp_matches(str_none_alphabet, '^[^a-zA-Z]+$'))
)
