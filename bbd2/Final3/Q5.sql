-- Question 5 --
SELECT doc.id_doctorant, COUNT (pl.id_article)
FROM publier_laas pl
RIGHT JOIN doctorant doc ON doc.id_doctorant = pl.id_personnel 
GROUP BY doc.id_doctorant
;
