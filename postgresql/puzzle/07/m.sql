CREATE TABLE IF NOT EXISTS Files
(
  id INTEGER NOT NULL PRIMARY KEY
)
CREATE TABLE IF NOT EXISTS Portfolios
(
  id INTEGER NOT NULL PRIMARY KEY,
  file_id INTEGER NOT NULL REFERENCES Files(id),
  versioning_id INTEGER NOT NULL, -- version管理ID
  version_no INTEGER NOT NULL,    -- version number
  issue_date DATE NOT NULL,
  UNIQUE (versioning_id, version_no)
)
;

-- あるバージョンの後続バージョンを追跡できること
SELECT *
FROM Portfolios
WHERE versioning_id = 1
AND version_no >= 1
;

-- あるバージョンの先行バージョンを追跡できること
SELECT *
FROM Portfolios
WHERE versioning_id = 1
AND version_no <= 1
;

-- 過去のバージョン(file_id = 8)を復活できること
INSERT INTO Portfolios
VALUES (
  SELECT MAX(id) + 1 FROM Portfolios,
  8
  1,
  SELECT MAX(version_no) + 1 FROM Portfolios WHERE versioning_id = 1,
  CURRENT_DATE
)
;

-- issue_date列によってあるファイルバージョンの発行日を突き止められること
SELECT issue_date
WHERE versioning_id = 1
AND version_no = 1
ORDER BY issue_date DESC
LIMIT 1
;

-- SELECT分にどんなバージョンが含まれていようと、最新バージョンは選択できること
-- 最新バージョンの一覧を取得できると理解
WITH latests AS (
  SELECT p1.versioning_id AS versioning_id,
         MAX(p1.version_no) AS version_no
  FROM Portfolios p1
  GROUP BY p1.versioning_id
)
SELECT *
FROM Portfolios p2
WHERE p2.versioning_id = latests.versioning_id
AND p2.version_no = latests.version_no
;

-- バージョンの連鎖を調べる監査証跡を再作成できること
-- 何をいっているのか理解できなかった
;
