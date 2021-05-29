CREATE TABLE occupations (
  name VARCHAR2(10),
  occupation VARCHAR2(9),
);

INSERT INTO occupations VALUES ('Helen','Journalist');
INSERT INTO occupations VALUES ('Alison','Doctor');
INSERT INTO occupations VALUES ('Dylan','Actor');
INSERT INTO occupations VALUES ('Frank','Actor');
INSERT INTO occupations VALUES ('Gavin','Doctor');
INSERT INTO occupations VALUES ('Paul','Professor');
INSERT INTO occupations VALUES ('Yang','Journalist');
INSERT INTO occupations VALUES ('Gary','Singer');
INSERT INTO occupations VALUES ('Marvin','Singer');
INSERT INTO occupations VALUES ('Vikii','Singer');
INSERT INTO occupations VALUES ('George','Journalist');

Question:Write the first query to display names and first letter of occupations and sort alphabetically by names
Wite the second query to count total number of each occupation, sort by the occurance and then alphabetically by occupations 


Sample Output
Alison(D)
Dylan(A)
Frank(A)
Gary(S)
Gavin(D)
George(J)
Helen(J)
Marvin(S)
Paul(P)
Vikii(S)
Yang(J)
There are a total of 1 professors.
There are a total of 2 actors.
There are a total of 2 doctors.
There are a total of 3 journalists.
There are a total of 3 singers.

/* Version 1*/
In oracle, CONCAT() can only concat two arguments at once, if CONCAT('X','Y','Z'), it will throw an error

SELECT CONCAT(name,CONCAT('(',CONCAT(SUBSTR(occupation,1,1),')'))) FROM occupations;
SELECT 'There are a total of ' ||  COUNT(*) || ' ' || LOWER(occupation) ||'s.'  FROM occupations GROUP BY occupation ORDER BY COUNT(*), occupation;



/* Version 2*/
It is recommended to use double piping || in replacement of CONCAT() when muptiple strings/characters needs to be concat

SELECT name || '(' || SUBSTR(occupation,1,1) || ')' FROM occupations ORDER BY name;
SELECT 'There are a total of ' ||  COUNT(*) || ' ' || LOWER(occupation) ||'s.'  FROM occupations GROUP BY occupation ORDER BY COUNT(*), occupation;



/* Version 3*/
Use UNION to combine the results of two querys, while using UNION, We cannot use Order By clause with individual Select statement.
We can use it with result set generated from the Union of both Select statements.

SELECT name || '(' || SUBSTR(occupation,1,1) || ')' 
FROM occupation
UNION 
SELECT 'There are a total of ' ||  COUNT(*) || ' ' || LOWER(occupation) ||'s.'  
FROM occupations GROUP BY occupation;



/* Version 4*/
View two queries as two tables with same schema (same column# and column names), use UNION ALL to append the two results of two queries 

SELECT foo FROM(
( SELECT name || '(' || SUBSTR(occupation,1,1) || ')' as foo,
  RANK() OVER (ORDER BY name) as rnk,
  '1' as query_tag FROM occupations )
UNION ALL
( SELECT 'There are a total of ' || COUNT(occupation) || ' ' || LOWER(occupation) || 's.' as foo,
 RANK() OVER (ORDER BY COUNT(occupation), occupation) as rnk,
 '2' as query_tag FROM occupations
GROUP BY occupation)
    ) 
ORDER BY query_tag, rnk




