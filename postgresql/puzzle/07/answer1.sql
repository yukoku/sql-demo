CREATE TABLE IF NOT EXISTS Portfolios
(
  file_id INTEGER NOT NULL PRIMARY KEY,
  stuff CHAR(15) NOT NULL
)
;

INSERT INTO Portfolios
VALUES (222, 'stuff'),
       (223, 'old stuff'),
       (224, 'new stuff'),
       (225, 'borrowed stuff'),
       (322, 'blue stuff'),
       (323, 'purple stuff'),
       (324, 'red stuff'),
       (325, 'green stuff'),
       (999, 'yellow stuff')

CREATE TABLE IF NOT EXISTS Succession
(
  chain INTEGER NOT NULL,
  next INTEGER DEFAULT 0 NOT NULL CHECK (next >= 0),
  file_id INTEGER NOT NULL REFERENCES Portfolios(file_id),
  suc_date DATE NOT NULL,
  PRIMARY KEY (chain, next)
)

INSERT INTO Succession
VALUES (1, 0, 222, '2007-11-01'),
       (1, 1, 223, '2007-11-02'),
       (1, 2, 224, '2007-11-04'),
       (1, 3, 225, '2007-11-05'),
       (1, 4, 999, '2007-11-25'),
       (2, 0, 322, '2007-11-01'),
       (2, 1, 323, '2007-11-02'),
       (2, 2, 324, '2007-11-04'),
       (2, 3, 322, '2007-11-05'),
       (2, 4, 323, '2007-11-12'),
       (2, 5, 999, '2007-11-25')


-- SELECT分にどんなバージョンが含まれていようと、最新バージョンは選択できること
SELECT DISTINCT P1.file_id, stuff, suc_date
FROM Portfolios AS P1, Succession AS S1
WHERE P1.file_id = S1.file_id
AND next = (
  SELECT MAX(next)
  FROM Succession AS S2
  WHERE S1.chain = S2.chain
)
;

-- バージョンの連鎖を調べる監査証跡を再作成できること
SELECT chain, next, P1.file_id, stuff, suc_date
FROM Portfolios AS P1, Succession AS S1
WHERE S1.file_id = P1.file_id
ORDER BY chain, next
;

-- あるバージョンの先行バージョンを追跡できること
-- あるバージョンの後続バージョンを追跡できること
SELECT S1.file_id, 'superseded', S2.file_id, 'on', S1.suc_date
FROM Succession AS S1, Succession AS S2
WHERE S1.chain = S2.chain
AND S1.next = S2.next + 1 -- ここをマイナスにすれば後続
AND S1.file_id = :my_file_id
;

-- 過去のバージョンを復活できること
BEGIN
  INSERT INTO Portfolios VALUES (1000, 'sticky stuff');
  INSERT INTO Succession (chain, next, file_id, suc_date)
  VALUES (
    (
      SELECT DISTINCT chain
      FROM Succession AS S1
      WHERE S1.file_id = :old_file_id
    ),
    (
      SELECT MAX(next) + 1
      FROM Succession AS S1
      WHERE S1.chain = (
        SELECT DISTINCT chain
        FROM Succession AS S2
        WHERE file_id = :old_file_id
      )
    ),
    :new_file_id,
    :new_suc_date
  );
END
;

-- issue_date列によってあるファイルバージョンの発行日を突き止められること
-- 略
