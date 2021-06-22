use quanlysv;
select address, count(studentid) as amountOfStudent
from student
group by address;

select s.studentId, s.studentname, avg(mark) as average
from student s join Mark m on s.studentid = m.studentid
group by s.studentid,s.studentname;

select s.studentid, s.studentname, avg(mark) as average
from student s join mark m on s.studentid = m.studentid
group by s.studentid,s.studentname
having average > 15;

SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);