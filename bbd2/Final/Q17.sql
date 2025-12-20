-- Question 17 --

SELECT id_chercheur
FROM participation_projet
GROUP BY id_chercheur
HAVING COUNT(id_projet) = 1;