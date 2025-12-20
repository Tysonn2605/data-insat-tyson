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
INSERT INTO doctorant (id_doctorant, annee_debutthese, annee_soutenance) VALUES
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