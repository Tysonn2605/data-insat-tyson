-- Question 1 --

SELECT p.nom, c.grade
FROM personnel p, chercheur c, encadrement e
WHERE p.id_personnel = c.id_chercheur
    AND p.id_personnel = e.id_chercheur
    AND e.id_doctorant = 'd001';
