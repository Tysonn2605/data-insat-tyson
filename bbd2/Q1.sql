-- Question 1 --
SELECT nom, grade
FROM personnel p 
    JOIN doctorant d ON p.id_personnel = d.id_doctorant
    JOIN encadrement e ON d.id_doctorant = e.id_doctorant
    JOIN chercheur c ON e.id_chercheur = c.id_chercheur 
WHERE d.id_doctorant = 'd001';