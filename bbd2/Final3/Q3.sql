-- Question 3 --

SELECT COUNT(DISTINCT p.id_partenaire)
FROM partenariat_projet p
RIGHT JOIN participation_projet c ON c.id_projet = p.id_projet
AND c.id_chercheur = 's001';
