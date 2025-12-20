-- Question 12 --

SELECT DISTINCT p1.id_personnel
FROM publier_laas p1
WHERE NOT EXISTS (
    SELECT a.id_article
    FROM article a, conference c, publier_laas p2
    WHERE p1.id_personnel = p2.id_personnel
        AND p2.id_article = a.id_article
        AND a.id_conference = c.id_conference
        AND c.classe_conference != 'A'
)
AND p1.id_personnel IN (
    SELECT c.id_chercheur
    FROM chercheur c
);
