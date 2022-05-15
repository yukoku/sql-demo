-- わからんかった
SELECT
  p1.proc_id AS proc_id,
  COUNT() AS max_inst_count
FROM Procs p1
LEFT OUTER JOIN (
  SELECT p2.proc_id as proc_id,
         p2.anest_name as anest_name,
         -- めんどいので漏れてる時間帯は省略
         CASE WHEN '07:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t1,
         CASE WHEN '07:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t2,
         CASE WHEN '08:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t2,
         CASE WHEN '08:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t3,
         CASE WHEN '09:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t4,
         CASE WHEN '09:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t5,
         CASE WHEN '10:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t6,
         CASE WHEN '10:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t7,
         CASE WHEN '11:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t8,
         CASE WHEN '11:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t9,
         CASE WHEN '12:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t10,
         CASE WHEN '12:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t11,
         CASE WHEN '13:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t12,
         CASE WHEN '13:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t13,
         CASE WHEN '14:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t14,
         CASE WHEN '14:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t15,
         CASE WHEN '15:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t16,
         CASE WHEN '15:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t17,
         CASE WHEN '16:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t18,
         CASE WHEN '16:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t20,
         CASE WHEN '17:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t21,
         CASE WHEN '17:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t22,
         CASE WHEN '18:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t23,
         CASE WHEN '18:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t24,
         CASE WHEN '19:00' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t25,
         CASE WHEN '19:30' BETWEEN start_time AND end_time THEN TRUE ELSE FALSE END as t26
  FROM Procs p2
) p
ON p1.proc_id = p.proc_id
;
