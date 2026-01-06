-- Question 9 --

SELECT p.nom, p.prenom
FROM personnel p
WHERE p.id_personnel IN (
    SELECT DISTINCT e1.id_chercheur
    FROM encadrement e1
    WHERE NOT EXISTS (
        SELECT *
        FROM doctorant d
        JOIN encadrement e2 ON e2.id_doctorant = d.id_doctorant
        WHERE e1.id_chercheur = e2.id_chercheur
        AND d.annee_soutenance IS NOT NULL)
);
