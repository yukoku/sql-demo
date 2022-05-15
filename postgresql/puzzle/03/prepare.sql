CREATE TABLE IF NOT EXISTS Procs
(
  proc_id INTEGER NOT NULL PRIMARY KEY,
  anest_name CHAR(40) NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL
);

INSERT INTO Procs (proc_id, anest_name, start_time, end_time) VALUES (10, 'Baker', '08:00', '11:00');
INSERT INTO Procs (proc_id, anest_name, start_time, end_time) VALUES (20, 'Baker', '09:00', '13:00');
INSERT INTO Procs (proc_id, anest_name, start_time, end_time) VALUES (30, 'Dow', '09:00', '15:30');
INSERT INTO Procs (proc_id, anest_name, start_time, end_time) VALUES (40, 'Dow', '08:00', '13:30');
INSERT INTO Procs (proc_id, anest_name, start_time, end_time) VALUES (50, 'Dow', '10:00', '11:30');
INSERT INTO Procs (proc_id, anest_name, start_time, end_time) VALUES (60, 'Dow', '12:30', '13:30');
INSERT INTO Procs (proc_id, anest_name, start_time, end_time) VALUES (70, 'Dow', '13:30', '14:30');
INSERT INTO Procs (proc_id, anest_name, start_time, end_time) VALUES (80, 'Dow', '18:00', '19:00');
