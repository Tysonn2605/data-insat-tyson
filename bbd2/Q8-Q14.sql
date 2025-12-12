-- Question 8 --

SELECT nom, prénom
FROM personnel
WHERE id_personnel IN (
SELECT id_chercheur
FROM chercheur
WHERE id_chercheur NOT IN (
SELECT id_chercheur
FROM encadrement)
AND id_personnel NOT IN (
	SELECT id_personnel
FROM publier_laas);

-- Question 9 --

SELECT nom, prénom
FROM personnel
WHERE id_personnel IN (
SELECT id_chercheur
FROM encadrement e
WHERE NOT EXISTS (
SELECT *
FROM doctorant d
WHERE e.id_doctorant = d.id_doctorant
AND d.annee_soutenance != NULL)
);

-- Question 10 --

SELECT id_personnel, nom, prénom
FROM personnel
WHERE id_personnel IN (
SELECT id_doctorant, COUNT(id_chercheur)
FROM encadrement
GROUP BY id_doctorant
HAVING COUNT(id_chercheur) = 1
);

-- Question 11 --

SELECT A.id_personnel, A.nom, A.prenom, COUNT(A.id_doctorant)
FROM (
	SELECT *
	FROM encadrement
LEFT JOIN personnel ON personnel.id_personnel = encadrement.id_chercheur
) A
GROUP BY A.id_personnel
HAVING COUNT(A.id_doctorant) > 4

-- Question 12 --

SELECT DISTINCT id_personnel
FROM publier_laas p1
WHERE NOT EXISTS (
SELECT *
FROM publier_laas p2
LEFT JOIN (
	SELECT *
	FROM article a
	LEFT JOIN conference ON a.id_conference = conference.id_conference
) R ON p2.id_article = R.id_article
WHERE p1.id_personnel = R.id_personnel
AND R.classe_conference != ‘A’
);

-- Question 13 --

SELECT id_personnel, nom, prénom
FROM personnel
WHERE id_personnel IN (
SELECT id_chercheur
FROM encadrement e1
WHERE NOT EXISTS (
SELECT id_doctorant
FROM doctorant d
WHERE NOT EXISTS (
SELECT id_chercheur
FROM encadrement e2
WHERE e1.id_chercheur = e2.id_chercheur
AND d.id_doctorant = e2.id_doctorant
)
)
);

-- Question 14 --

SELECT R.annee_conference, COUNT(R.id_article)
FROM (
	SELECT *
	FROM article
	LEFT JOIN conference ON article.conference = conference.id_conference) R
GROUP BY R.annee_conference
ORDER BY R.annee_conference;

