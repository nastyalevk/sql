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
SELECT name, COUNT(name) as count
FROM (SELECT T.id, P.passenger
FROM Trip AS T RIGHT JOIN Pass_in_trip AS P ON T.id=P.trip) AS Trip_Pass, Passenger
WHERE Trip_Pass.passenger=Passenger.id
GROUP BY name
HAVING COUNT(Trip_Pass.id)>=1 
ORDER BY count DESC ;
--19
SELECT status
FROM (SELECT good_name, family_member FROM Goods RIGHT JOIN Payments ON Goods.good_id=Payments.good) as pg RIGHT JOIN  FamilyMembers ON FamilyMembers.member_id=pg.family_member
WHERE good_name='potato'
GROUP BY member_id;
--20
SELECT status, member_name, SUM(unit_price*amount) as costs
FROM (SELECT good_name, Goods.type, family_member, unit_price, amount FROM Goods RIGHT JOIN Payments ON Goods.good_id=Payments.good) as pg RIGHT JOIN  FamilyMembers ON FamilyMembers.member_id=pg.family_member, GoodTypes
WHERE GoodTypes.good_type_id= pg.type AND  good_type_name='entertainment'
GROUP BY member_id;
WHERE good_name='potato'
GROUP BY member_id;