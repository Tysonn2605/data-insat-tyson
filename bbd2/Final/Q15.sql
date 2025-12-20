-- Question 15 --

SELECT id_etablissement, COUNT(id_enseignant) AS nombre_enseignant
FROM enseignant_chercheur
GROUP BY id_etablissement;
