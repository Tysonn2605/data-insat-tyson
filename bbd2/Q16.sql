-- Question 16 --

SELECT pays, COUNT(id_article)
FROM (
    laboratoire_externe le
    JOIN auteur_externe ae ON le.id_laboratoire_externe = ae.id_laboratoire_externe
    JOIN publier_externe pe ON pe.id_auteur_externe = ae.id_auteur_externe
    ) t
GROUP BY pays
ORDER BY COUNT(id_article) DESC
LIMIT 1;