-- Question 1 --

SELECT p.nom, c.grade
FROM personnel p
JOIN chercheur c ON p.id_personnel = c.id_chercheur 
JOIN encadrement e ON p.id_personnel = e.id_chercheur 
WHERE e.id_doctorant = 'd001';
