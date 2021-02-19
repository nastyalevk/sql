--1
SELECT name
FROM Passenger;
--2
SELECT name
FROM Company;
--3
SELECT *
FROM Trip
WHERE town_from='Moscow';
--4
SELECT name
FROM Passenger
WHERE RIGHT(name, 3)='man';
--5
SELECT COUNT(id) AS count
FROM Trip
WHERE plane="TU-134";
--6
SELECT C.name
FROM Trip AS  T, Company AS C
WHERE T.company=C.id AND T.plane='Boeing'
GROUP BY T.company;
--7
SELECT plane
FROM Trip
WHERE town_to='Moscow'
GROUP BY plane;
--9
SELECT name
FROM Trip AS T, Company AS C
WHERE T.company=C.id AND T.town_from='Vladivostok'
GROUP BY C.name;
--11
SELECT name
FROM Passenger
WHERE LENGTH(name)=(SELECT MAX(LENGTH(name))
FROM Passenger);
--12
SELECT trip, COUNT(passenger) AS count
FROM Pass_in_trip
GROUP BY trip;
--13
SELECT name
FROM  Passenger
GROUP BY name
HAVING COUNT(name)>=2
--14
SELECT town_to
FROM (SELECT town_to, P.passenger
      FROM Trip AS T RIGHT JOIN Pass_in_trip AS P ON T.id=P.trip) AS Town_Pass, Passenger
WHERE Town_Pass.passenger=Passenger.id AND
 Passenger.name='Bruce Willis';
--16
SELECT name, COUNT(name) AS count
FROM (SELECT T.id, P.passenger
      FROM Trip AS T RIGHT JOIN Pass_in_trip AS P ON T.id=P.trip) AS Trip_Pass, Passenger
WHERE Trip_Pass.passenger=Passenger.id
GROUP BY name
HAVING COUNT(Trip_Pass.id)>=1 
ORDER BY count DESC ;
--19
SELECT status
FROM (SELECT good_name, family_member 
      FROM Goods RIGHT JOIN Payments ON Goods.good_id=Payments.good) AS pg RIGHT JOIN  FamilyMembers ON FamilyMembers.member_id=pg.family_member
WHERE good_name='potato'
GROUP BY member_id;
--20
SELECT status, member_name, SUM(unit_price*amount) AS costs
FROM (SELECT good_name, Goods.type, family_member, unit_price, amount 
      FROM Goods RIGHT JOIN Payments ON Goods.good_id=Payments.good) AS pg RIGHT JOIN  FamilyMembers ON FamilyMembers.member_id=pg.family_member, GoodTypes
      WHERE GoodTypes.good_type_id= pg.type AND  good_type_name='entertainment'
GROUP BY member_id;
WHERE good_name='potato'
GROUP BY member_id;
--21
SELECT good_name
FROM Goods, Payments
WHERE Payments.good = Goods.good_id
GROUP BY good
HAVING COUNT(good)>1;
--22
SELECT member_name
FROM FamilyMembers
WHERE status='mother';
--23
SELECT good_name, unit_price
FROM Payments RIGHT JOIN (SELECT good_id, good_name
                          FROM GoodTypes, Goods
                          WHERE  GoodTypes.good_type_id=Goods.type AND                 
                          good_type_name='delicacies') AS deli ON deli.good_id=Payments.good 
LIMIT 1;
--28
SELECT COUNT(T.id) AS count
FROM Trip AS T
WHERE town_from='Rostov' AND  town_to='Moscow';
--29
SELECT DISTINCT  name 
FROM (SELECT passenger
FROM  Trip LEFT JOIN Pass_in_trip ON Trip.id=Pass_in_trip.trip
WHERE town_to='Moscow' AND plane='TU-134')as r LEFT JOIN Passenger ON r.passenger=Passenger.id 
--30
SELECT trip, COUNT(id) AS count
FROM Pass_in_trip 
GROUP BY trip
ORDER BY count DESC;
--31
SELECT *
FROM FamilyMembers
WHERE member_name LIKE '% Quincey';
--32
SELECT FLOOR(AVG(TIMESTAMPDIFF(year, birthday, CURRENT_TIMESTAMP()))) as age
FROM FamilyMembers;
--33
SELECT AVG(unit_price) as cost
FROM Goods g JOIN Payments p ON g.good_id=p.good
WHERE good_name LIKE '% caviar';
--34
SELECT COUNT(name)as count 
FROM Class
WHERE name LIKE '10 %';
--36
SELECT *
FROM Student
WHERE address LIKE 'ul. Pushkina%';
--37
SELECT MIN(TIMESTAMPDIFF(year, birthday, CURRENT_TIMESTAMP())) AS year
FROM Student;
--38
SELECT COUNT(id) AS count
FROM Student
WHERE first_name='Anna' ;
--39
SELECT COUNT(student) AS count
FROM Class c JOIN Student_in_class s ON c.id=s.class
WHERE c.name='10 B';
--40
SELECT sj.name AS subjects
FROM Teacher t JOIN Schedule s ON t.id=s.teacher 
               JOIN Subject as sj ON sj.id = subject
WHERE t.last_name='Romashkin';
--41
SELECT start_pair
FROM Timepair
WHERE id=4;
--42
SELECT TIMEDIFF(MAX(end_pair), MIN(start_pair)) AS time
FROM Timepair
WHERE id>=2 AND id<=4;
--43
SELECT last_name
FROM Teacher t JOIN Schedule s ON t.id=s.teacher 
               JOIN Subject as sj ON sj.id = subject
Where sj.name='Physical Culture'
ORDER BY last_name;
--44
SELECT MAX(TIMESTAMPDIFF(year, birthday, CURRENT_TIMESTAMP())) AS max_year
FROM Class AS c JOIN Student_in_class AS st ON c.id=st.class 
                JOIN Student AS s ON st.student=s.id
WHERE c.name LIKE '10 %';
--45
SELECT classroom 
FROM Schedule 
GROUP BY classroom
HAVING COUNT(classroom)=(SELECT COUNT(classroom) as count
                         FROM Schedule
                         GROUP BY classroom
                         ORDER BY  classroom DESC 
                         LIMIT 1);
--46
SELECT name
FROM Schedule AS s JOIN Class AS c ON s.class=c.id 
                   JOIN Teacher AS t ON t.id=s.teacher
WHERE t.last_name='Krauze'
GROUP BY name;
--47
SELECT COUNT(Schedule.id) AS count
FROM Schedule JOIN Teacher ON Teacher.id=Schedule.teacher
WHERE date='2019-08-30' AND last_name='Krauze';
--48
SELECT name, COUNT(s.id) as count
FROM Class c JOIN Student_in_class s ON c.id=s.class
GROUP BY c.name 
ORDER BY count DESC;
--49
SELECT (COUNT(s.id)*100/(SELECT COUNT(*) FROM Student_in_class)) AS percent
FROM Class c JOIN Student_in_class s ON c.id=s.class
Where c.name='10 A';
--50
SELECT FLOOR(COUNT(id)*100/(SELECT COUNT(*) FROM Student)) AS percent
FROM Student 
WHERE YEAR(birthday)=2000;
