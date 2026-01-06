-- Question 7 --

SELECT p.nom, p.prenom
FROM personnel p
JOIN chercheur c ON p.id_personnel = c.id_chercheur
WHERE c.id_chercheur NOT IN (
	SELECT e.id_chercheur 
	FROM encadrement e
	)
;
