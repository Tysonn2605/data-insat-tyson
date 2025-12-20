-- Question 14 --

SELECT c.annee_conference, COUNT(a.id_article)
FROM article a, conference c
WHERE c.id_conference = a.id_conference
GROUP BY c.annee_conference
ORDER BY c.annee_conference;
