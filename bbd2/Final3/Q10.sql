-- Question 10 --

SELECT id_personnel, nom, prenom
FROM personnel
WHERE id_personnel IN (
    SELECT id_doctorant
    FROM encadrement
    GROUP BY id_doctorant
    HAVING COUNT(id_chercheur) = 1
);