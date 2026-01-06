-- Question 21 --

SELECT pays
FROM partenaire p
JOIN partenariat_projet pp ON p.id_partenaire = pp.id_partenaire
GROUP BY pays
HAVING COUNT(DISTINCT id_projet) = (
    SELECT COUNT(id_projet)
    FROM projet_recherche
)