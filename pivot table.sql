CREATE TABLE occupations (
  name VARCHAR2(10),
  occupation VARCHAR2(9),
);

INSERT INTO occupations VALUES ('Samantha', 'Doctor');
INSERT INTO occupations VALUES ('Julia','Actor');
INSERT INTO occupations VALUES ('Maria','Actor');
INSERT INTO occupations VALUES ('Meera','Actor');
INSERT INTO occupations VALUES ('Ashely','Professor');
INSERT INTO occupations VALUES ('Ketty','Professor');
INSERT INTO occupations VALUES ('Christeen','Professor');
INSERT INTO occupations VALUES ('Jane','Actor');
INSERT INTO occupations VALUES ('Jenny','Doctor');
INSERT INTO occupations VALUES ('Priya','Singer');


Question: Rearrange occupations table from tablue form to pivot form

Name        Occupation                                                                     
Samantha    Doctor                                                          
Julia       Actor                                  
Maria       Actor                             Doctor      Professor     Singer     Actor
Meera       Singer                            Jenny       Ashley        Meera      Jane
Ashely      Professor       ------------>     Samantha    Christeen     Priya      Julia 
Ketty       Professor                         Null        Ketty         Null       Maria                                                                                             
Christeen   Professor                                                                                                                                                                                            
Jane        Actor
Jenny       Doctor                                                                                                                                              
Priya       Singer


/*Solution 1 */
WITH data AS ( SELECT name, occupation, ROW_NUMBER() OVER( PARTITION BY occupation ORDER BY name) AS rn FROM occupations)   
  
SELECT Doctor, Professor, Singer, Actor 
FROM ( 
  SELECT * FROM data 
  PIVOT (MIN(name) FOR occupation IN ('Doctor' AS Doctor, 'Professor' AS Professor, 'Singer' AS Singer, 'Actor' AS Actor)
  )
ORDER BY rn
);



/*Solution 2 */
Select Doctor, Professor, Singer, Actor 
FROM (
  SELECT * FROM (SELECT name, occupation, (ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name)) as rn FROM occupations) 
  PIVOT ( MAX(name) FOR occupation IN ('Doctor' AS Doctor, 'Professor' AS Professor, 'Singer' AS Singer, 'Actor' AS Actor)
  ) 
ORDER BY rn
); 
      


/*Solution 3 */
SELECT Doctor, Professor, Singer, Actor 
FROM (SELECT name, occupation,(ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name)) as rn FROM occupations) 
PIVOT (MIN(name) FOR occupation IN ('Doctor' AS Doctor, 'Professor' AS Professor, 'Singer' AS Singer, 'Actor' AS Actor))
ORDER BY rn;



/*Solution 4 */
SELECT MAX(Doctor), MAX(Professor), MAX(Singer), MAX(Actor)
FROM(
  Select  ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name) rn,
    CASE occupation WHEN 'Doctor' THEN name END AS Doctor,
    CASE occupation WHEN 'Professor' THEN name END AS Professor,
    CASE occupation WHEN 'Singer' THEN name END AS Singer,
    CASE occupation WHEN 'Actor' THEN name END AS Actor
  FROM occupations)
GROUP BY rn
ORDER BY rn;

      








