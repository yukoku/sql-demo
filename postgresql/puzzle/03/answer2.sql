SELECT P3.proc_id,
       MAX(ConcurrentProcs.tally)
FROM (
  SELECT P1.anest_name,
         P1.start_time,
         COUNT(*)
  FROM Procs AS P1
  INNER JOIN Procs AS P2
    ON P1.anest_name = P2.anest_name
    AND P2.start_time <= P1.start_time
    AND P2.end_time > P1.start_time
  GROUP BY P1.anest_name, P1.start_time
) AS ConcurrentProcs(anest_name, start_time, tally)
INNER JOIN Procs AS P3
  ON ConcurrentProcs.anest_name = P3.anest_name
  AND P3.start_time <= ConcurrentProcs.start_time
  AND P3.end_time > ConcurrentProcs.start_time
GROUP BY P3.proc_id
;
