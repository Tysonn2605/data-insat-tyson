-- Question 2 --
SELECT DISTINCT ae.nom, le.pays
FROM laboratoire_externe le
JOIN auteur_externe ae ON ae.id_laboratoire_externe = le.id_laboratoire_externe
JOIN publier_externe pe ON pe.id_auteur_externe = ae.id_auteur_externe
JOIN article a ON pe.id_article = a.id_article
JOIN publier_laas pl ON pl.id_article = a.id_article
JOIN conference c ON a.id_conference = c.id_conference
JOIN personnel p ON p.id_personnel = pl.id_personnel
WHERE p.nom = 'Azi'
AND p.prenom = 'Jean'
AND c.annee_conference >= 2016
AND c.annee_conference <= 2020;
