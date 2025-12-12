-- Question 15 --

SELECT id_etablissement, COUNT(id_enseignant) AS nombre_enseignant
FROM enseignant-chercheur
GROUP BY id_etablissement;

-- Question 16 --

SELECT le.pays
FROM (
    laboratoire_externe le
    JOIN auteur_extern ae ON le.id_laboratoire_externe = ae.id_laboratoire_externe
    JOIN publier_externe pe ON pe.id_auteur_externe = ae.id_auteur_externe
    ) t
GROUP BY le.pays
ORDER BY COUNT(pe.id_article) DESC
LIMIT 1;

-- Question 17 --

SELECT id_chercheur
FROM participation_projet
WHERE COUNT(id_chercheur) = 1;

-- Question 18 --

SELECT id_chercheur
FROM participation_projet
GROUP BY id_chercheur
HAVING COUNT(DISTINCT id_projet) = (
    SELECT COUNT(DISTINCT id_projet)
    FROM projet_recherche
    );

-- Question 19 --

SELECT id_etablissement
FROM (
    enseignant-chercheur ec
    JOIN personnel p ON ec.id_enseignant = p.id_personnel
    ) t
GROUP BY id_etablissement
HAVING COUNT(id_personnel) > 50;

-- Question 20 --

SELECT id_chercheur
FROM participation_projet
GROUP BY id_chercheur
ORDER BY COUNT(id_projet) DESC
LIMIT 1

-- Question 21 --

SELECT pays
FROM (
    partenaire p
    JOIN partenariat_projet pp ON p.id_partenaire = pp.id_partenaire
    ) t
GROUP BY pays
HAVING COUNT(DISTINCT id_projet) = (
    SELECT COUNT(id_projet)
    FROM projet_recherche
)

--iK1ohwai
--iK1ohwai