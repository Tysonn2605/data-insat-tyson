-- Question 9 --

SELECT p.nom, p.prenom
FROM personnel p
WHERE p.id_personnel IN (
    SELECT DISTINCT e1.id_chercheur
    FROM encadrement e1
    WHERE NOT EXISTS (
        SELECT *
        FROM doctorant d, encadrement e2
        WHERE e1.id_chercheur = e2.id_chercheur
            AND e2.id_doctorant = d.id_doctorant
            AND d.annee_soutenance IS NOT NULL)
);
