use quanlysv;
select * from subject
where credit = (select max(credit) from subject);

select * from subject, mark
where subject.subid = mark.subid
having mark.Mark = (select max(mark) from mark);

select *,avg(mark) from mark, student
where student.studentID = mark.studentID
group by mark.studentID
order by avg(mark) desc;