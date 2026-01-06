-- Question 15 --

SELECT ee.id_etablissement, COUNT(id_enseignant) AS nombre_enseignant
FROM enseignant_chercheur ec
RIGHT JOIN etablissement_enseignement ee ON ec.id_etablissement = ee.id_etablissement
GROUP BY ee.id_etablissement;
