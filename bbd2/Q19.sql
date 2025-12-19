-- Question 19 --

SELECT id_etablissement
FROM (
    enseignant_chercheur ec
    JOIN personnel p ON ec.id_enseignant = p.id_personnel
    ) t
GROUP BY id_etablissement
HAVING COUNT(id_personnel) > 50;