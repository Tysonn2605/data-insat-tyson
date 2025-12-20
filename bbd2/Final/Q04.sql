-- Question 4 --

SELECT COUNT (DISTINCT l.pays)
FROM    laboratoire_externe l,
        article a, 
        publier_laas pl, 
        publier_externe pe, 
        auteur_externe ae, 
        conference c
WHERE pl.id_article = a.id_article 
    AND l.id_laboratoire_externe = ae.id_laboratoire_externe
    AND c.id_conference = a.id_conference 
    AND pe.id_article = a.id_article 
    AND ae.id_auteur_externe = pe.id_auteur_externe 
    AND c.classe_conference='A';
