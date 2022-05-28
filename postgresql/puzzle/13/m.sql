CREATE TABLE IF NOT EXISTS Register
(
  course_nbr INTEGER NOT NULL,
  student_name CHAR(10) NOT NULL,
  teacher_name CHAR(10) NOT NULL
)
;

-- answer02と同じだった
SELECT course_nbr,
       student_name,
       MIN(teacher_name) AS first_teacher_name,
       CASE COUNT(teacher_name)
       WHEN 1 THEN ''
       WHEN 2 THEN MAX(teacher_name)
       ELSE '--More--' AS second_teacher_name,
FROM Register r
GROUP BY course_nbr, student_name
;
