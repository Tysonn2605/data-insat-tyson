-- Question 1 --
SELECT p.nom, c.grade
FROM personnel p, chercheur c
WHERE p .id_personnel = c.id_chercheur AND c.id_chercheur = "d001"
;
-- Question 2 --
SELECT p.nom, p.pays
FROM partenaire p, projet_recherche r, partenariat_projet pr
WHERE p.id_partenaire = pr.id_partenaire AND pr.id_projet=r.id_projet AND r.id_porteur= "Jean Azi" AND r.annee_debut >= 2016 AND r.annee_debut <= 2020
;
-- Question 3 --
SELECT COUNT(p.id_partenaire)
FROM partenariat_projet p, partcipation_projet c
WHERE c.id_projet=p.id_projet AND c.id_chercheur= « S001 »
;
-- Question 4 --
SELECT COUNT(Distinct l.pays)
FROM laboratoire_externe l, article a, publier_laas pl, publier_externe pe, auteur_externe ae, Conférence c
WHERE pl.id_article=a.id_article AND l.id_laboratoire_externe=ae.id_laboratoire_externe AND c.id_conférence=a.id_conférence AND pe.id_article=a.id_article AND ae.id_auteur_externe=pe.id_auteur_externe AND c.classe_conférence=A
;
-- Question 5 --
SELECT COUNT(pl.idarticle)
FROM publier_laas pl, article a, doctorant doc
WHERE doc.id_doctorant=pl.id_personnel AND pl.id_article=a.id_article
GROUP BY id_doctorant
;
-- Question 6 --
SELECT COUNT(id_doctorant)
FROM doctorant
WHERE annee_soutenance != NULL
;
-- Question 7 --
SELECT p.nom,p .prénom
FROM Personnel p, Chercheur c
WHERE p.id_personnel=c.id_chercheur AND c.id_chercheur NOT IN (SELECT id_chercheur FROM encadrement)
;
