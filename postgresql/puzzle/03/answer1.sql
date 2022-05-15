CREATE VIEW Events
(proc_id, comparison_proc, anest_name, event_time, event_type) AS
SELECT P1.proc_id, P2.proc_id, P1.anest_name, P2.start_time, +1
FROM Procs AS P1, Procs AS P2
WHERE P1.anest_name = P2.anest_name
AND NOT (P2.end_time <= P1.start_time OR P2.start_time >= P1.end_time)
UNION
SELECT P1.proc_id, P2.proc_id, P1.anest_name, P2.end_time, -1
FROM Procs AS P1, Procs AS P2
WHERE P1.anest_name = P2.anest_name
AND NOT (P2.end_time <= P1.start_time OR P2.start_time >= P1.end_time)
;

CREATE VIEW ConcurrentProcs
(proc_id, event_time, instantaneous_count) AS
SELECT E1.proc_id,
       E1.event_time,
       (SELECT SUM(E2.event_type)
        FROM Events AS E2
        WHERE E2.proc_id = E1.proc_id
        AND E2.event_time < E1.event_time
       ) AS instantaneous_count
FROM Events AS E1
ORDER BY E1.proc_id, E1.event_time
;

SELECT proc_id, MAX(instantaneous_count) AS max_inst
FROM ConcurrentProcs
GROUP BY proc_id
;
