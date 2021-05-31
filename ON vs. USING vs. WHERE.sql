Question: Query the names of students whose best friend's salary is higher than them 

Students:               Friends:                Packages:                                                                          
ID Name                 ID Friend_ID            ID  Salary                                                                  
1  Samantha             1   3                   1   15.5                                   
2  Julia                2   4                   2   15.6                                             
3  Britney              3   2                   3   16.7                                             
4  Kristeen             4   1                   4   18.8                         



/* Solution 1*/
SELECT name FROM ( 
  students s JOIN friends f ON s.id=f.id  
  JOIN packages p1 ON f.id=p1.id 
  JOIN packages p2 ON p2.id=f.friend_id
  ) 
WHERE p1.salary < p2.salary 
ORDER BY p2.salary
;



/* Solution 2*/
SELECT s.name
FROM (students s JOIN friends f USING(id)
      JOIN Packages p1 USING(id)
      JOIN Packages p2 ON f.friend_id=P2.id)
WHERE p2.salary > P1.salary
ORDER BY p2.salary
;



/* Solution 3*/
SELECT s.name FROM students s, friends f, packages p1, packages p2 
WHERE s.id = f.id AND 
      s.id = p1.id AND 
      f.friend_id = p2.id AND 
      P2.salary>p1.salary 
ORDER BY p2.salary
;



**Note**
Difference between USING & ON:
1. USING requires joined columns with same name while ON doesn't
2. USING will print joined column just once
3. When using USING, we cannot put a qualifier(table name or Alias) in the referenced columns

ON output:
s.ID  s.Name  f.ID  f.Friend_ID  p1.ID   p1.Salary   p2.ID    p2.Salary
2     Julia     2        4         2       15.6        4        18.8
1     Samantha  1        3         1       15.5        3        16.7

/////////////////////////   VS.   ////////////////////////////////////

USING output:
ID  s.Name  f.Friend_ID  p1.Salary   p2.ID    p2.Salary
2    Julia      4           15.6       4        18.8
1     Samantha  3           15.5       3        16.7
















