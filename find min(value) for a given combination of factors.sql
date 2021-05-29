CREATE TABLE cars (
  vin NUMBER(17) CONSTRAINT PK_cars PRIMARY KEY,
  code NUMBER(2),
  price NUMBER(6),
  power NUMBER(4),
);

CREATE TABLE cars_property (
  code NUMBER(2) CONSTRAINT PK_cars_property PRIMARY KEY,
  mileage_range NUMBER(2),
  is_clean_title NUMBER(1),
);


Question: Look for the cheapest clean title car for a given combination of mileage_range and power in used car markets



/* Solution 1*/
Step1: Join tables to get master table with all the info
Step2: Filter out not clean title cars
Step3: Group by mileage_range and power, find the lowest price for a given combination of power and mileage_range
Step4: Create a new view based on the above table and keep only cheapest cars at given combination of power and mileage_range
Step5: Order new list by decending order of power and ascending order of mileage_range

SELECT vin, price, mileage_range, power
FROM
    (SELECT vin, mileage_range, price, power, MIN(price) OVER(PARTITION BY c.power, p.mileage_range ) miniprice 
      FROM
            cars c JOIN cars_property p ON c.code=p.code 
      WHERE is_clean_title=1)
WHERE price=miniprice
ORDER BY power DESC, mileage_range ASC
;



/* Solution 2*/
SELECT vin, price, mileage_range, power 
FROM 
    cars c JOIN cars_property p ON c.code = p.code 
WHERE p.is_clean_title = 1 AND c.price = 
                                      (SELECT MIN(price) FROM cars c1 
                                       JOIN cars_property p1 ON (w1.code = p1.code) 
                                       WHERE c1.power = c.power AND p1.mileage_range = p.mileage_range )
ORDER BY POWER DESC, AGE DESC



/* Solution 3*/
WITH mi AS 
(SELECT power, mileage_range, MIN(price) aa FROM cars c JOIN cars_property p ON c.code=p.code 
 WHERE is_clean_title=1 GROUP BY power, mileage_range),jt AS 
(SELECT vin, power, mileage_range, price FROM cars c1 JOIN cars_property p1 ON c1.code=p1.code 
 WHERE is_clean_title=1) 

SELECT vin, mi.mileage_range, price, mi.power FROM 
mi, jt WHERE mi.mileage_range=jt.mileage_range AND mi.power=jt.power AND mi.aa=jt.price
ORDER BY power DESC, mileage_range DESC;











