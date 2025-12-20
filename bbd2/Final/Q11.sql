-- Question 11 --

SELECT p.id_personnel, p.nom, p.prenom, COUNT(e.id_doctorant)
FROM personnel p, encadrement e 
WHERE p.id_personnel = e.id_chercheur
GROUP BY p.id_personnel
HAVING COUNT(e.id_doctorant) > 4;
