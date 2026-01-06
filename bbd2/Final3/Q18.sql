-- Question 18 --

SELECT id_chercheur
FROM participation_projet
GROUP BY id_chercheur
HAVING COUNT(DISTINCT id_projet) = (
    SELECT COUNT(DISTINCT id_projet)
    FROM projet_recherche
    );