-- no constraints yet.

alter table Schedule
add check (semester_year > 0);

alter table Schedule
add check (semester = 'Fall' or semester = 'Spring');

