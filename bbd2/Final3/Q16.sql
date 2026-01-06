-- Question 16 --

SELECT le.pays, COUNT(pe.id_article)
FROM laboratoire_externe le
JOIN auteur_externe ae ON le.id_laboratoire_externe = ae.id_laboratoire_externe
JOIN publier_externe pe ON pe.id_auteur_externe = ae.id_auteur_externe
GROUP BY le.pays
HAVING COUNT(pe.id_article) = (
    SELECT COUNT(pe2.id_article)
    FROM laboratoire_externe le2
    JOIN auteur_externe ae2 ON le2.id_laboratoire_externe = ae2.id_laboratoire_externe
    JOIN publier_externe pe2 ON pe2.id_auteur_externe = ae2.id_auteur_externe
    GROUP BY le2.pays
    ORDER BY COUNT(pe2.id_article) DESC
    LIMIT 1
);