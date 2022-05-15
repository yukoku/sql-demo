CREATE TABLE IF NOT EXISTS DayTicks
(
  ticks TIME NOT NULL,
)
INSERT INTO DayTicks VALUES ('00:00');
INSERT INTO DayTicks VALUES ('00:01');
INSERT INTO DayTicks VALUES ('00:02');
-- 以下一日分の分刻みテーブルを作成する

CREATE VIEW Clock
(clock_time) AS
SELECT CURRENT_DATE + ticks FROM DayTicks

SELECT X.anest_name,
       MAX(X.proc_tally)
FROM (
  SELECT P1.anest_name,
         COUNT(DISTINCT proc_id)
  FROM Procs AS P1, Clock AS C
  WHERE C.clock_time BETWEEN P1.start_time AND P1.end_time
  GROUP BY P1.anest_name
) AS X(anest_name, proc_tally)
GROUP BY X.anest_name
;
