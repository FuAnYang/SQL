CREATE TABLE participants (
    particiantid int NOT NULL PRIMARY KEY,
    name varchar(255),
);

CREATE TABLE difficulty (
    level int,
    score int,
);

CREATE TABLE questions (
    questionid int NOT NULL PRIMARY KEY,
    participantsid int,
    level int
);


CREATE TABLE submissions (
    submissionid int NOT NULL PRIMARY KEY,
    participantid int,
    questionid int,
    score int,
);

/////////////////////////////////////////////////////////////////////Question///////////////////////////////////////////////////////////////////////
Question: List all the participants who received full scores for more than one questions, arrange the output by descending order of number of questions with full scores and ascending order by participantid

Step1: Join tables together to make a master table which contains all the info
Step2: Filter out submissions that did not earn full score
Step3: Remove participants who only had one full-score submission
Step4: Display output by descending order of total submissions with full score and acsending order by participantid 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SELECT participantid, name 
FROM submissions s 
      INNER JOIN questions q ON s.questionid=q.questionid 
      INNER JOIN difficulty d ON d.level=q.level
      INNER JOIN participant p ON p.participantid=s.participantid
WHERE s.score=d.score AND d.level=q.level
GROUP BY participantid, name
HAVING COUNT(s.participantid)>1
ORDER BY COUNT(s.participantid)DESC, participantid ASC
;



