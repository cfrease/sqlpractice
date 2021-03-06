--Crime Report
SELECT description
FROM crime_scene_report
WHERE city = 'SQL City'
AND date = 20180115
AND type = 'murder';

--Security footage shows that there were 2 witnesses. 
--The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".


--Witnesses
SELECT name, transcript
FROM person AS p
JOIN interview AS i 
ON i.person_id = p.id
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

--Morty Schapiro
--I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
--The membership number on the bag started with "48Z". 
--Only gold members have those bags. The man got into a car with a plate that included "H42W".

SELECT name, transcript
FROM person AS p
JOIN interview AS i 
ON i.person_id = p.id
WHERE address_street_name = 'Franklin Ave'
AND name LIKE 'Annabel%';

--Annabel Miller
--I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.


--Witness ID, Name,  and Statements
WITH witness1 AS (
SELECT id, name 
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC LIMIT 1), 
witness2 AS (
SELECT id, name
FROM person
WHERE name LIKE 'Annabel%'
AND address_street_name = 'Franklin Ave'), 
witnesses AS (
SELECT *
FROM witness1
UNION
SELECT *
FROM witness2)
SELECT id, name, transcript 
FROM witnesses
LEFT JOIN interview 
ON witnesses.id = interview.person_id

--14887	Morty Schapiro	
--I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
--The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
--16371	Annabel Miller	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

--Name Query
SELECT p.id, m.name, d.plate_number, d.gender, m.membership_status
FROM get_fit_now_member AS m
JOIN get_fit_now_check_in AS i
ON m.id= i.membership_id
JOIN person AS p
ON m.name = p.name
JOIN drivers_license AS d
ON p.license_id = d.id
WHERE i.check_in_date = '20180109'
AND m.membership_status = 'gold'
AND i.membership_id LIKE '%48Z%'
AND d.plate_number LIKE '%H42W%'

WITH t1 AS (
SELECT m.person_id, m.name, m.membership_status 
FROM get_fit_now_member AS m
JOIN get_fit_now_check_in AS i
ON m.id = i.membership_id
WHERE m.membership_status = 'gold' 
AND m.id LIKE '%48Z%'
AND i.check_in_date = '20180109' ), 
t2 AS (
SELECT t1.person_id, t1.name, d.plate_number, d.gender, t1.membership_status
FROM t1
JOIN person AS p
ON t1.person_id = p.id
JOIN drivers_license AS d
ON p.license_id = d.id)
SELECT * 
FROM t2
WHERE plate_number LIKE '%H42W%'
 AND gender = 'male'

--67318	Jeremy Bowers

--Confession
SELECT transcript
FROM interview
WHERE person_id = 67318

--I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
--She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

--Real Suspect
SELECT p.name, count(*) as event_count
FROM drivers_license AS d
JOIN person AS p
ON d.id = p.license_id
JOIN facebook_event_checkin AS fb 
ON fb.person_id = p.id
WHERE d.hair_color = 'red'
AND d.car_make = 'Tesla'
AND d.car_model = 'Model S'
AND d.gender = 'female'
AND d.height BETWEEN 65 AND 67
AND fb.event_name = 'SQL Symphony Concert'

--Miranda Priestly	3