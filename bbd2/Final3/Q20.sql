-- Question 20 --

SELECT id_chercheur
FROM participation_projet
GROUP BY id_chercheur
HAVING COUNT(id_projet) = (
    SELECT COUNT(id_projet)
    FROM participation_projet
    GROUP BY id_chercheur
    ORDER BY COUNT(id_projet) DESC
    LIMIT 1
)