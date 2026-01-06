-- Question 19 --

SELECT ee.id_etablissement
FROM etablissement_enseignement ee
LEFT JOIN enseignant_chercheur ec ON ec.id_etablissement = ee.id_etablissement
GROUP BY ee.id_etablissement
HAVING COUNT(ec.id_enseignant) > 50;