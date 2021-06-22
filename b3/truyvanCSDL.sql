use quanlysv;
select * from student
where StudentName like 'h%';

select * from class
where month(startdate) = 12;

select * from subject
where credit between 3 and 5;

set sql_safe_updates =0;
update student
set classID = 2 where studentname ='Hung';

select s.Studentname, sub.subname, m.mark
from student s, subject sub, mark m
where s.studentID = m.StudentID and sub.SubID = m.SubID
order by mark desc, StudentName asc;