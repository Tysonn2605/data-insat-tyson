-- Question 7 --

SELECT p.nom, p.prenom
FROM personnel p, chercheur c
WHERE p.id_personnel = c.id_chercheur AND c.id_chercheur NOT IN (
	SELECT e.id_chercheur 
	FROM encadrement e
	);
