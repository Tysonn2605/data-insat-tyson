-- Question 2 --

SELECT p.nom, p.pays
FROM partenaire p, projet_recherche r, partenariat_projet pr, personnel pe
WHERE p.id_partenaire = pr.id_partenaire
    AND pr.id_projet = r.id_projet
    AND r.id_porteur = pe.id_personnel
    AND pe.nom = 'Azi'
    AND pe.prenom = 'Jean'
    AND r.annee_debut >= 2016
    AND r.annee_debut <= 2020;