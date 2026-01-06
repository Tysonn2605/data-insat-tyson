-- Question 13 --

SELECT id_personnel, nom, prenom
FROM personnel
WHERE id_personnel IN (
    SELECT id_chercheur
    FROM encadrement e1
    WHERE NOT EXISTS (
        SELECT id_doctorant
        FROM doctorant d
        WHERE NOT EXISTS (
            SELECT id_chercheur
            FROM encadrement e2
            WHERE e1.id_chercheur = e2.id_chercheur
            AND d.id_doctorant = e2.id_doctorant
        )
    )
);
