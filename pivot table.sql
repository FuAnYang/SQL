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
INSERT INTO occupations VALUES ('Allen','Singer');
INSERT INTO occupations VALUES ('Priya','Singer');
INSERT INTO occupations VALUES ('Jackson','Singer');


Question: Rearrange occupations table from tablue form to pivot form

Name        Occupation                                                                     
Samantha    Doctor                                                          
Julia       Actor                                  
Maria       Actor                             Doctor      Professor     Singer     Actor
Meera       Singer                            Jenny       Ashley        Allen      Jane
Ashely      Professor       ------------>     Samantha    Christeen     Jackson    Julia 
Ketty       Professor                         Null        Ketty         Meera      Maria                                                                                             
Christeen   Professor                         Null        Null          Priya      Null                                                                                                                                                                   
Jane        Actor                            
Jenny       Doctor   
Allen       Singer
Priya       Singer
Jackson     Singer


/*Solution 1 */
WITH data AS ( SELECT name, occupation, ROW_NUMBER() OVER( PARTITION BY occupation ORDER BY name) AS rn FROM occupations)   
  
SELECT Doctor, Professor, Singer, Actor 
FROM ( 
  SELECT * FROM data 
  PIVOT (MIN(name) FOR occupation IN ('Doctor' AS Doctor, 'Professor' AS Professor, 'Singer' AS Singer, 'Actor' AS Actor)
  )
ORDER BY rn
);

Steps break down:
Jane        Actor     1                                                         
Julia       Actor     2                  
Jenny       Doctor    1
Samantha    Doctor    2
Ashely      Professor 1      
Ketty       Professor 2                                                                                                                 
Christeen   Professor 3                                                                                                                                                                                           
Allen       Singer    1                                                                                                                                          
Jackson     Singer    2
Meera       Singer    3                                                                                                                                          
Priya       Singer    4

















Eve Actor 1
Jennifer Actor 2
Ketty Actor 3
Samantha Actor 4
Aamina Doctor 1
Julia Doctor 2
Priya Doctor 3
Ashley Professor 1
Belvet Professor 2
Britney Professor 3
Maria Professor 4
Meera Professor 5
Naomi Professor 6
Priyanka Professor 7
Christeen Singer 1
Jane Singer 2
Jenny Singer 3
Kristeen Singer 4











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

      









