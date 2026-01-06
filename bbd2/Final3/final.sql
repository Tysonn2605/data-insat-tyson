-- TABLE personnel
CREATE TABLE IF NOT EXISTS personnel (
    id_personnel VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(20),
    prenom VARCHAR(20),
    annee_recrutement INTEGER,
    date_naissance DATE,
    adresse VARCHAR(50)
);

 --TABLE Chercheur
CREATE TABLE IF NOT EXISTS chercheur (
    id_chercheur VARCHAR(10) PRIMARY KEY,
    grade VARCHAR(20),
    FOREIGN KEY (id_chercheur) REFERENCES personnel(id_personnel)
);

-- TABLE Doctorant
CREATE TABLE IF NOT EXISTS doctorant (
    id_doctorant VARCHAR(10) PRIMARY KEY,
    annee_debut_these INTEGER,
    annee_soutenance INTEGER,
    FOREIGN KEY (id_doctorant) REFERENCES personnel(id_personnel)
);

 -- TABLE Encadrement
CREATE TABLE IF NOT EXISTS encadrement (
    id_doctorant VARCHAR(10),
    id_chercheur VARCHAR(10),
    PRIMARY KEY (id_doctorant, id_chercheur),
    FOREIGN KEY (id_doctorant) REFERENCES doctorant(id_doctorant),
    FOREIGN KEY (id_chercheur) REFERENCES chercheur(id_chercheur)
);

-- TABLE Conference
CREATE TABLE IF NOT EXISTS conference (
    id_conference VARCHAR(10) PRIMARY KEY,
    nom_conference VARCHAR(50),
    annee_conference INTEGER,
    classe_conference VARCHAR(20)
);

-- TABLE Article
CREATE TABLE IF NOT EXISTS article (
    id_article VARCHAR(10) PRIMARY KEY,
    titre VARCHAR(50),
    id_conference VARCHAR(10),
    FOREIGN KEY (id_conference) REFERENCES conference(id_conference)

);

-- TABLE PublierLAAS
CREATE TABLE IF NOT EXISTS publier_laas (
    id_personnel VARCHAR(10),
    id_article VARCHAR(10),
    PRIMARY KEY (id_personnel, id_article),
    FOREIGN KEY (id_personnel) REFERENCES personnel(id_personnel),
    FOREIGN KEY (id_article) REFERENCES article(id_article)
);

-- TABLE LaboratoireExterne
CREATE TABLE IF NOT EXISTS laboratoire_externe (
    id_laboratoire_externe VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(20),
    pays VARCHAR(20)
);

-- TABLE AuteurExterne
CREATE TABLE IF NOT EXISTS auteur_externe (
    id_auteur_externe VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(20),
    prenom VARCHAR(20),
    adresse_email VARCHAR(30),
    id_laboratoire_externe VARCHAR(10),
    FOREIGN KEY (id_laboratoire_externe) REFERENCES laboratoire_externe(id_laboratoire_externe)
);

-- TABLE PublierExterne
CREATE TABLE IF NOT EXISTS publier_externe (
    id_auteur_externe VARCHAR(10),
    id_article VARCHAR(10),
    PRIMARY KEY (id_auteur_externe, id_article),
    FOREIGN KEY (id_auteur_externe) REFERENCES auteur_externe(id_auteur_externe),
    FOREIGN KEY (id_article) REFERENCES article(id_article)
);

-- TABLE EtablissementEnseignement
CREATE TABLE IF NOT EXISTS etablissement_enseignement (
    id_etablissement VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(20),
    acronyme VARCHAR(20),
    adresse VARCHAR(50)
);

-- TABLE Enseignant-Chercheur
CREATE TABLE IF NOT EXISTS enseignant_chercheur (
    id_enseignant VARCHAR(10) PRIMARY KEY,
    echelon VARCHAR(30),
    id_etablissement VARCHAR(10),
    FOREIGN KEY (id_enseignant) REFERENCES chercheur(id_chercheur),
    FOREIGN KEY (id_etablissement) REFERENCES etablissement_enseignement(id_etablissement)
);

-- TABLE ProjetRecherche
CREATE TABLE IF NOT EXISTS projet_recherche (
    id_projet VARCHAR(10) PRIMARY KEY,
    titre VARCHAR(50),
    acronyme VARCHAR(20),
    annee_debut INTEGER,
    duree INTEGER,
    cout_global INTEGER,
    budget_laas INTEGER,
    id_porteur VARCHAR(10) ,
    FOREIGN KEY (id_porteur) REFERENCES chercheur(id_chercheur)
);

-- TABLE ParticipationProjet
CREATE TABLE IF NOT EXISTS participation_projet (
    id_chercheur VARCHAR(10),
    id_projet VARCHAR(10),
    PRIMARY KEY (id_chercheur, id_projet),
    FOREIGN KEY (id_chercheur) REFERENCES chercheur(id_chercheur),
    FOREIGN KEY (id_projet) REFERENCES projet_recherche(id_projet)
);

-- TABLE Partenaire
CREATE TABLE IF NOT EXISTS partenaire (
    id_partenaire VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(20),
    pays VARCHAR(20)
);

-- TABLE PartenariatProjet
CREATE TABLE IF NOT EXISTS partenariat_projet (
    id_partenaire VARCHAR(10),
    id_projet VARCHAR(10),
    PRIMARY KEY (id_partenaire, id_projet),
    FOREIGN KEY (id_partenaire) REFERENCES partenaire(id_partenaire),
    FOREIGN KEY (id_projet) REFERENCES projet_recherche(id_projet)
);

BEGIN;

-- ------------------------------------------------------------
-- Cleanup
-- ------------------------------------------------------------
TRUNCATE TABLE partenariat_projet, participation_projet, projet_recherche, partenaire, 
               enseignant_chercheur, etablissement_enseignement, publier_externe, 
               publier_laas, auteur_externe, laboratoire_externe, encadrement, 
               doctorant, chercheur, article, conference, personnel 
RESTART IDENTITY CASCADE;

-- ------------------------------------------------------------
-- 1) personnel
-- ------------------------------------------------------------
INSERT INTO personnel (id_personnel, nom, prenom, annee_recrutement, date_naissance, adresse) VALUES
('s001','Azi','Jean',     2010,'1978-03-14','7 av. des Sciences, Toulouse'),
('s002','Martin','Sophie',2012,'1980-07-22','12 rue des Lilas, Toulouse'),
('s003','Lopez','Carlos', 2015,'1985-01-19','3 imp. des Fleurs, Toulouse'),
('s004','Nguyen','Linh',  2013,'1979-11-02','5 bd. Matabiau, Toulouse'),
('s005','Dubois','Marc',  2018,'1983-05-09','10 rue Périole, Toulouse'),
('s006','Durif','Alain',  2020,'1988-12-12','1 place du Capitole, Toulouse'),
('s007','Moreau','Julie', 2021,'1990-04-05','22 rue de Metz, Toulouse'),
('d001','Durand','Alice', 2019,'1995-02-10','2 rue Bayard, Toulouse'),
('d002','Petit','Hugo',   2018,'1993-09-05','4 rue des Arts, Toulouse'),
('d003','Rossi','Giulia', 2020,'1994-12-30','8 av. Lyon, Toulouse'),
('d004','Khan','Aamir',   2017,'1992-04-21','11 place Dupuy, Toulouse'),
('d005','Leroy','Zoe',    2021,'1997-01-11','50 rue de la République, Toulouse'),
('d006','Fontaine','Leo', 2022,'1998-06-15','14 rue des Chalets, Toulouse'),
('t001','Bernard','Claire',2016,'1987-08-16','6 rue Romiguières, Toulouse');

-- ------------------------------------------------------------
-- 2) chercheur
-- ------------------------------------------------------------
INSERT INTO chercheur (id_chercheur, grade) VALUES
('s001','cr1'), ('s002','mcf'), ('s003','cr2'), ('s004','mcf hors classe'), 
('s005','cr2'), ('s006','cr1'), ('s007','mcf');

-- ------------------------------------------------------------
-- 3) doctorant
-- ------------------------------------------------------------
INSERT INTO doctorant (id_doctorant, annee_debut_these, annee_soutenance) VALUES
('d001', 2019, NULL),
('d002', 2016, 2020),
('d003', 2020, NULL),
('d004', 2017, 2022),
('d005', 2021, NULL),
('d006', 2022, NULL);

-- ------------------------------------------------------------
-- 4) encadrement 
-- (s001 supervises >4 to test Q11; s001 supervises ALL to test Q13)
-- ------------------------------------------------------------
INSERT INTO encadrement (id_doctorant, id_chercheur) VALUES
('d001','s001'), ('d001','s002'), -- d001 has two supervisors
('d002','s001'),                  -- d002 has one
('d003','s001'), ('d003','s003'),
('d004','s001'), ('d004','s002'),
('d005','s001'), 
('d006','s001'),
('d002','s002'); -- s006 and s007 supervise NO ONE (to test Q7)

-- ------------------------------------------------------------
-- 5) conference
-- ------------------------------------------------------------
INSERT INTO conference (id_conference, nom_conference, annee_conference, classe_conference) VALUES
('c1','ICRA', 2016,'A'), ('c2','ICRA', 2018,'A'), ('c3','IROS', 2019,'A'),
('c4','IROS', 2020,'B'), ('c5','RSS',  2017,'A*'), ('c6','MED',  2016,'C'),
('c7','ECC',  2020,'A'), ('c8','CDC',  2018,'A'), ('c9','CDC',  2021,'A');

-- ------------------------------------------------------------
-- 6) article
-- ------------------------------------------------------------
INSERT INTO article (id_article, titre, id_conference) VALUES
('a1','Path Planning','c1'), ('a2','Coordination','c2'), ('a3','Vision','c3'),
('a4','Safe RL','c4'), ('a5','Tactile','c5'), ('a6','Embedded','c6'),
('a7','MPC','c7'), ('a8','Delays','c8'), ('a9','Learning','c9');

-- ------------------------------------------------------------
-- 7) publier_laas 
-- (s002 publishes ONLY in Class A to test Q12)
-- ------------------------------------------------------------
INSERT INTO publier_laas (id_personnel, id_article) VALUES
('s001','a1'), ('s001','a2'), ('s001','a4'), ('s001','a8'),
('s002','a3'), ('s002','a8'), ('s002','a9'), -- s002 only A/A*
('d001','a2'), ('d001','a3'),
('d002','a1'), ('d002','a6'), -- d002 has publications
('s003','a5'), ('s005','a7'),
('s004','a6'); -- s006 and s007 have NO publications (to test Q8)

-- ------------------------------------------------------------
-- 8) externe
-- ------------------------------------------------------------
INSERT INTO laboratoire_externe (id_laboratoire_externe, nom, pays) VALUES
('lab1','MIT','USA'), ('lab2','TUM','Allemagne'), ('lab3','Polimi','Italie');

INSERT INTO auteur_externe (id_auteur_externe, nom, prenom, adresse_email, id_laboratoire_externe) VALUES
('ae1','Smith','John','j@mit.edu','lab1'),
('ae2','Müller','Anna','a@tum.de','lab2'),
('ae3','Bianchi','Luca','l@polimi.it','lab3');

INSERT INTO publier_externe (id_auteur_externe, id_article) VALUES
('ae1','a1'), ('ae2','a1'), -- a1 is Class A (USA/Germany)
('ae3','a3'), ('ae1','a8'),
('ae2','a7');

-- ------------------------------------------------------------
-- 9) enseignement
-- ------------------------------------------------------------
INSERT INTO etablissement_enseignement (id_etablissement, nom, acronyme, adresse) VALUES
('e1','UT3 Paul Sabatier','UT3','Toulouse'),
('e2','INSA Toulouse','INSA','Toulouse');

INSERT INTO enseignant_chercheur (id_enseignant, echelon, id_etablissement) VALUES
('s002','HC','e2'), ('s004','HC','e2'), ('s007','C1','e1');

-- ------------------------------------------------------------
-- 10) projets 
-- (s001 participates in ALL to test Q18)
-- ------------------------------------------------------------
INSERT INTO projet_recherche (id_projet, titre, acronyme, annee_debut, duree, cout_global, budget_laas, id_porteur) VALUES
('p1','Drone Inspect','AERO',2018,36,100000,40000,'s001'),
('p2','Tactile Viz','TACT',2019,48,200000,50000,'s003'),
('p3','Green MPC','ENER',2020,24,150000,20000,'s005');

INSERT INTO participation_projet (id_chercheur, id_projet) VALUES
('s001','p1'), ('s001','p2'), ('s001','p3'), -- s001 in all
('s002','p1'), ('s003','p2'), ('s005','p3'),
('s004','p1'); -- s004 only in one

INSERT INTO partenaire (id_partenaire, nom, pays) VALUES
('par1','Airbus','France'), ('par2','Siemens','Allemagne'), ('par3','ENEL','Italie');

INSERT INTO partenariat_projet (id_partenaire, id_projet) VALUES
('par1','p1'), ('par2','p1'), ('par3','p1'), -- Italy/Germany/France in p1
('par1','p2'), ('par2','p2'), ('par3','p2'),
('par1','p3'), ('par2','p3'), ('par3','p3'); -- Testing "Countries in ALL projects" (Q21)

COMMIT;

-- Question 1 --

SELECT p.nom, c.grade
FROM personnel p
JOIN chercheur c ON p.id_personnel = c.id_chercheur 
JOIN encadrement e ON p.id_personnel = e.id_chercheur 
WHERE e.id_doctorant = 'd001';

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

-- Question 3 --

SELECT COUNT(DISTINCT p.id_partenaire)
FROM partenariat_projet p
RIGHT JOIN participation_projet c ON c.id_projet = p.id_projet
AND c.id_chercheur = 's001';

-- Question 4 --

SELECT COUNT (DISTINCT le.pays)
FROM laboratoire_externe le
LEFT JOIN auteur_externe ae ON le.id_laboratoire_externe = ae.id_laboratoire_externe
JOIN publier_externe pe ON ae.id_auteur_externe = pe.id_auteur_externe
JOIN article a ON pe.id_article = a.id_article
JOIN publier_laas pl ON a.id_article = pl.id_article
JOIN conference c ON a.id_conference = c.id_conference
WHERE c.classe_conference = 'A';

-- Question 5 --

SELECT doc.id_doctorant, COUNT (pl.id_article)
FROM publier_laas pl
RIGHT JOIN doctorant doc ON doc.id_doctorant = pl.id_personnel 
GROUP BY doc.id_doctorant;

-- Question 6 --

SELECT COUNT (id_doctorant)
FROM doctorant
WHERE annee_soutenance IS NOT NULL;

-- Question 7 --

SELECT p.nom, p.prenom
FROM personnel p
JOIN chercheur c ON p.id_personnel = c.id_chercheur
WHERE c.id_chercheur NOT IN (
	SELECT e.id_chercheur 
	FROM encadrement e
);

-- Question 8 --

SELECT p.nom, p.prenom
FROM personnel p
JOIN chercheur c ON p.id_personnel = c.id_chercheur 
WHERE c.id_chercheur NOT IN (
	SELECT e.id_chercheur 
	FROM encadrement e
) 
AND c.id_chercheur NOT IN (
	SELECT p.id_personnel
	FROM publier_laas p
);

-- Question 9 --

SELECT p.nom, p.prenom
FROM personnel p
WHERE p.id_personnel IN (
    SELECT DISTINCT e1.id_chercheur
    FROM encadrement e1
    WHERE NOT EXISTS (
        SELECT *
        FROM doctorant d
        JOIN encadrement e2 ON e2.id_doctorant = d.id_doctorant
        WHERE e1.id_chercheur = e2.id_chercheur
        AND d.annee_soutenance IS NOT NULL
    )
);

-- Question 10 --

SELECT id_personnel, nom, prenom
FROM personnel
WHERE id_personnel IN (
    SELECT id_doctorant
    FROM encadrement
    GROUP BY id_doctorant
    HAVING COUNT(id_chercheur) = 1
);

-- Question 11 --

SELECT p.id_personnel, p.nom, p.prenom, COUNT(e.id_doctorant)
FROM personnel p 
JOIN encadrement e ON p.id_personnel = e.id_chercheur
GROUP BY p.id_personnel
HAVING COUNT(e.id_doctorant) > 4;

-- Question 12 --

SELECT DISTINCT p1.id_personnel
FROM publier_laas p1
WHERE NOT EXISTS (
    SELECT a.id_article
    FROM article a
    JOIN publier_laas p2 ON p2.id_article = a.id_article
    JOIN conference c ON a.id_conference = c.id_conference
    WHERE p1.id_personnel = p2.id_personnel
    AND c.classe_conference != 'A'
)
AND p1.id_personnel IN (
    SELECT c.id_chercheur
    FROM chercheur c
);

-- Question 13 --

SELECT id_personnel, nom, prenom
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

SELECT c.annee_conference, COUNT(a.id_article)
FROM article a
JOIN conference c ON c.id_conference = a.id_conference
GROUP BY c.annee_conference
ORDER BY c.annee_conference;

-- Question 15 --

SELECT ee.id_etablissement, COUNT(id_enseignant) AS nombre_enseignant
FROM enseignant_chercheur ec
RIGHT JOIN etablissement_enseignement ee ON ec.id_etablissement = ee.id_etablissement
GROUP BY ee.id_etablissement;

-- Question 16 --

SELECT le.pays, COUNT(pe.id_article)
FROM laboratoire_externe le
JOIN auteur_externe ae ON le.id_laboratoire_externe = ae.id_laboratoire_externe
JOIN publier_externe pe ON pe.id_auteur_externe = ae.id_auteur_externe
GROUP BY le.pays
HAVING COUNT(pe.id_article) = (
    SELECT COUNT(pe2.id_article)
    FROM laboratoire_externe le2
    JOIN auteur_externe ae2 ON le2.id_laboratoire_externe = ae2.id_laboratoire_externe
    JOIN publier_externe pe2 ON pe2.id_auteur_externe = ae2.id_auteur_externe
    GROUP BY le2.pays
    ORDER BY COUNT(pe2.id_article) DESC
    LIMIT 1
);

-- Question 17 --

SELECT id_chercheur
FROM participation_projet
GROUP BY id_chercheur
HAVING COUNT(id_projet) = 1;

-- Question 18 --

SELECT id_chercheur
FROM participation_projet
GROUP BY id_chercheur
HAVING COUNT(DISTINCT id_projet) = (
    SELECT COUNT(DISTINCT id_projet)
    FROM projet_recherche
);
    
-- Question 19 --

SELECT ee.id_etablissement
FROM etablissement_enseignement ee
LEFT JOIN enseignant_chercheur ec ON ec.id_etablissement = ee.id_etablissement
GROUP BY ee.id_etablissement
HAVING COUNT(ec.id_enseignant) > 50;

-- Question 20 --

SELECT id_chercheur
FROM participation_projet
GROUP BY id_chercheur
HAVING COUNT(id_projet) = (
    SELECT COUNT(id_projet)
    FROM participation_projet
    GROUP BY id_chercheur
    ORDER BY COUNT(id_projet) DESC
    LIMIT 1
);

-- Question 21 --

SELECT pays
FROM partenaire p
JOIN partenariat_projet pp ON p.id_partenaire = pp.id_partenaire
GROUP BY pays
HAVING COUNT(DISTINCT id_projet) = (
    SELECT COUNT(id_projet)
    FROM projet_recherche
);


