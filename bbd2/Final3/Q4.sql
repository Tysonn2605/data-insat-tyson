-- Q4 --
SELECT COUNT (DISTINCT le.pays)
FROM laboratoire_externe le
LEFT JOIN auteur_externe ae ON le.id_laboratoire_externe = ae.id_laboratoire_externe
JOIN publier_externe pe ON ae.id_auteur_externe = pe.id_auteur_externe
JOIN article a ON pe.id_article = a.id_article
JOIN publier_laas pl ON a.id_article = pl.id_article
JOIN conference c ON a.id_conference = c.id_conference
WHERE c.classe_conference = 'A';
