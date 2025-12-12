
-- ============================================================
-- Jeu de données (PostgreSQL) aligné sur CreateTable.sql
-- ============================================================

BEGIN;

-- ------------------------------------------------------------
-- 0) Nettoyage (ordre inverse des dépendances)
-- ------------------------------------------------------------
TRUNCATE TABLE
  partenariat_projet,
  participation_projet,
  projet_recherche,
  partenaire,
  enseignant_chercheur,
  etablissement_enseignement,
  publier_externe,
  publier_laas,
  auteur_externe,
  laboratoire_externe,
  encadrement,
  doctorant,
  chercheur,
  article,
  conference,
  personnel
RESTART IDENTITY CASCADE;

-- ------------------------------------------------------------
-- 1) personnel (id_personnel, nom, prenom, annee_recrutement, date_naissance, adresse)
--    chercheurs s001..s005 ; doctorants d001..d004 ; t001 (autre personnel)
-- ------------------------------------------------------------
INSERT INTO personnel (id_personnel, nom, prenom, annee_recrutement, date_naissance, adresse) VALUES
-- Chercheurs
('s001','Azi','Jean',     2010,'1978-03-14','7 av. des Sciences, Toulouse'),
('s002','Martin','Sophie',2012,'1980-07-22','12 rue des Lilas, Toulouse'),
('s003','Lopez','Carlos', 2015,'1985-01-19','3 imp. des Fleurs, Toulouse'),
('s004','Nguyen','Linh',  2013,'1979-11-02','5 bd. Matabiau, Toulouse'),
('s005','Dubois','Marc',  2018,'1983-05-09','10 rue Périole, Toulouse'),
-- Doctorants
('d001','Durand','Alice', 2019,'1995-02-10','2 rue Bayard, Toulouse'),
('d002','Petit','Hugo',   2018,'1993-09-05','4 rue des Arts, Toulouse'),
('d003','Rossi','Giulia', 2020,'1994-12-30','8 av. Lyon, Toulouse'),
('d004','Khan','Aamir',   2017,'1992-04-21','11 place Dupuy, Toulouse'),
-- Autre personnel (pour tester publier_laas hors chercheur/doctorant)
('t001','Bernard','Claire',2016,'1987-08-16','6 rue Romiguières, Toulouse');

-- ------------------------------------------------------------
-- 2) chercheur (id_chercheur, grade)  FK -> personnel(id_personnel)
-- ------------------------------------------------------------
INSERT INTO chercheur (id_chercheur, grade) VALUES
('s001','cr1'),
('s002','mcf'),
('s003','cr2'),
('s004','mcf hors classe'),
('s005','cr2');

-- ------------------------------------------------------------
-- 3) doctorant (id_doctorant, annee_debutthese, annee_soutenance) FK -> personnel
--    d001 en cours ; d002 soutenu 2020 ; d003 en cours ; d004 soutenu 2022
-- ------------------------------------------------------------
INSERT INTO doctorant (id_doctorant, annee_debutthese, annee_soutenance) VALUES
('d001',2019, NULL),
('d002',2016, 2020),
('d003',2020, NULL),
('d004',2017, 2022);

-- ------------------------------------------------------------
-- 4) encadrement (id_doctorant, id_chercheur)
--    d001: s001 & s002 ; d002: s001 ; d003: s003,s004,s005 ; d004: s002
-- ------------------------------------------------------------
INSERT INTO encadrement (id_doctorant, id_chercheur) VALUES
('d001','s001'),
('d001','s002'),
('d002','s001'),
('d003','s003'),
('d003','s004'),
('d003','s005'),
('d004','s002');

-- ------------------------------------------------------------
-- 5) conference (id_conference, nom_conference, annee_conference, classe_conference)
-- ------------------------------------------------------------
INSERT INTO conference (id_conference, nom_conference, annee_conference, classe_conference) VALUES
('c1001','ICRA', 2016,'A'),
('c1002','ICRA', 2018,'A'),
('c1003','IROS', 2019,'A'),
('c1004','IROS', 2020,'B'),
('c1005','RSS',  2017,'A*'),
('c1006','MED',  2016,'C'),
('c1007','ECC',  2020,'A'),
('c1008','CDC',  2018,'A'),
('c1009','CDC',  2021,'A'),
('c1010','ICUAS',2019,'B');

-- ------------------------------------------------------------
-- 6) article (id_article, titre, id_conference)  FK -> conference
-- ------------------------------------------------------------
INSERT INTO article (id_article, titre, id_conference) VALUES
('a2001','Planning under uncertainty for mobile robots','c1001'),
('a2002','Multi-agent coordination with constraints',   'c1002'),
('a2003','Vision-based grasping with deep learning',    'c1003'),
('a2004','Safe RL for UAV navigation',                  'c1004'),
('a2005','Tactile sensing for manipulation',            'c1005'),
('a2006','Embedded control on micro-UAVs',              'c1006'),
('a2007','Distributed MPC for energy systems',          'c1007'),
('a2008','Event-triggered control with delays',         'c1008'),
('a2009','Learning-based flight controllers',           'c1009'),
('a2010','Swarm path planning with obstacles',          'c1010');

-- ------------------------------------------------------------
-- 7) publier_laas (id_personnel, id_article) FKs -> personnel, article
-- ------------------------------------------------------------
INSERT INTO publier_laas (id_personnel, id_article) VALUES
-- a2001 (ICRA 2016, A) : Jean Azi + d002
('s001','a2001'),
('d002','a2001'),
-- a2002 (ICRA 2018, A) : Jean Azi + d001
('s001','a2002'),
('d001','a2002'),
-- a2003 (IROS 2019, A) : Sophie Martin + d001
('s002','a2003'),
('d001','a2003'),
-- a2004 (IROS 2020, B) : Jean Azi + d004
('s001','a2004'),
('d004','a2004'),
-- a2005 (RSS 2017, A*) : Carlos Lopez seul côté LAAS
('s003','a2005'),
-- a2006 (MED 2016, C) : Linh Nguyen + d002
('s004','a2006'),
('d002','a2006'),
-- a2007 (ECC 2020, A) : Dubois + d003
('s005','a2007'),
('d003','a2007'),
-- a2008 (CDC 2018, A) : Jean Azi + Sophie Martin
('s001','a2008'),
('s002','a2008'),
-- a2009 (CDC 2021, A) : Sophie Martin seule
('s002','a2009'),
-- a2010 (ICUAS 2019, B) : Dubois + t001 (autre personnel)
('s005','a2010'),
('t001','a2010');

-- ------------------------------------------------------------
-- 8) laboratoire_externe (id_laboratoire_externe, nom, pays)
-- ------------------------------------------------------------
INSERT INTO laboratoire_externe (id_laboratoire_externe, nom, pays) VALUES
('lab3001','MIT CSAIL','USA'),
('lab3002','TU Munich Robotics','Allemagne'),
('lab3003','Politecnico di Milano','Italie'),
('lab3004','KTH Royal Institute of Technology','Suède'),
('lab3005','Imperial College Dyson Lab','Royaume-Uni'),
('lab3006','KAIST RCV Lab','Corée du Sud');

-- ------------------------------------------------------------
-- 9) auteur_externe (id_auteur_externe, nom, prenom, adresse_email, id_laboratoire_externe)
-- ------------------------------------------------------------
INSERT INTO auteur_externe (id_auteur_externe, nom, prenom, adresse_email, id_laboratoire_externe) VALUES
('ae4001','Smith','John','john.smith@csail.mit.edu',        'lab3001'),
('ae4002','Müller','Anna','anna.mueller@tum.de',            'lab3002'),
('ae4003','Bianchi','Luca','luca.bianchi@polimi.it',        'lab3003'),
('ae4004','Svensson','Eva','eva.svensson@kth.se',           'lab3004'),
('ae4005','Brown','Emily','e.brown@imperial.ac.uk',         'lab3005'),
('ae4006','Kim','Min-Soo','minsoo.kim@kaist.ac.kr',         'lab3006');

-- ------------------------------------------------------------
-- 10) publier_externe (id_auteur_externe, id_article) FKs -> auteur_externe, article
--     Collaborations couvrant 2016–2020 pour "Jean Azi" (s001)
-- ------------------------------------------------------------
INSERT INTO publier_externe (id_auteur_externe, id_article) VALUES
-- a2001 (ICRA 2016, A) : USA, Allemagne
('ae4001','a2001'),
('ae4002','a2001'),
-- a2002 (ICRA 2018, A) : Royaume-Uni
('ae4005','a2002'),
-- a2003 (IROS 2019, A) : Italie, Suède
('ae4003','a2003'),
('ae4004','a2003'),
-- a2004 (IROS 2020, B) : Corée du Sud
('ae4006','a2004'),
-- a2005 (RSS 2017, A*) : USA
('ae4001','a2005'),
-- a2006 (MED 2016, C) : aucun externe
-- a2007 (ECC 2020, A) : Allemagne
('ae4002','a2007'),
-- a2008 (CDC 2018, A) : Royaume-Uni, USA
('ae4005','a2008'),
('ae4001','a2008'),
-- a2009 (CDC 2021, A) : Italie
('ae4003','a2009'),
-- a2010 (ICUAS 2019, B) : Suède
('ae4004','a2010');

-- ------------------------------------------------------------
-- 11) etablissement_enseignement (id_etablissement, nom, acronyme, adresse)
-- ------------------------------------------------------------
INSERT INTO etablissement_enseignement (id_etablissement, nom, acronyme, adresse) VALUES
('etab5001','Université Toulouse III - Paul Sabatier','UT3','118 route de Narbonne, Toulouse'),
('etab5002','INSA Toulouse','INSA','135 av. de Rangueil, Toulouse'),
('etab5003','Université de Montpellier','UM','Place Eugène Bataillon, Montpellier');

-- ------------------------------------------------------------
-- 12) enseignant_chercheur (id_enseignant, echelon, id_etablissement)
--     FKs -> chercheur(id_chercheur), etablissement_enseignement(id_etablissement)
-- ------------------------------------------------------------
INSERT INTO enseignant_chercheur (id_enseignant, echelon, id_etablissement) VALUES
('s002','HC-3','etab5002'),
('s004','HC-2','etab5002'),
('s003','CR-5','etab5001'),
('s005','CR-2','etab5003');

-- ------------------------------------------------------------
-- 13) projet_recherche
--     (id_projet, titre, acronyme, annee_debut, duree, cout_global, budget_laas, id_porteur)
-- ------------------------------------------------------------
INSERT INTO projet_recherche (id_projet, titre, acronyme, annee_debut, duree, cout_global, budget_laas, id_porteur) VALUES
('p6001','Robots aériens autonomes pour l’inspection','AEROINSPECT',2018,36,1200000,400000,'s001'),
('p6002','Manipulation robotique par vision tactile','TACTIVISION', 2019,48,1500000,500000,'s003'),
('p6003','Optimisation énergétique par contrôle prédictif','ENERG-MPC', 2020,24, 800000,250000,'s005'),
('p6004','Apprentissage sûr pour systèmes embarqués','SAFE-LEARN',  2017,60,2000000,700000,'s002');

-- ------------------------------------------------------------
-- 14) participation_projet (id_chercheur, id_projet)
-- ------------------------------------------------------------
INSERT INTO participation_projet (id_chercheur, id_projet) VALUES
('s001','p6001'),
('s002','p6001'),
('s003','p6001'),

('s001','p6002'),
('s003','p6002'),
('s004','p6002'),

('s003','p6003'),
('s005','p6003'),

('s001','p6004'),
('s002','p6004'),
('s004','p6004');

-- ------------------------------------------------------------
-- 15) partenaire (id_partenaire, nom, pays)
-- ------------------------------------------------------------
INSERT INTO partenaire (id_partenaire, nom, pays) VALUES
('par7001','Airbus','France'),
('par7002','Siemens','Allemagne'),
('par7003','ETH Zurich','Suisse'),
('par7004','ENEL','Italie'),
('par7005','Samsung','Corée du Sud'),
('par7006','MIT','USA');

-- ------------------------------------------------------------
-- 16) partenariat_projet (id_partenaire, id_projet)
-- ------------------------------------------------------------
INSERT INTO partenariat_projet (id_partenaire, id_projet) VALUES
-- p6001
('par7001','p6001'),('par7002','p6001'),('par7006','p6001'),
-- p6002
('par7002','p6002'),('par7003','p6002'),('par7004','p6002'),
-- p6003
('par7003','p6003'),('par7005','p6003'),
-- p6004
('par7001','p6004'),('par7002','p6004'),('par7005','p6004');

COMMIT;

-- ============================================================
-- Remarques de couverture rapide (diagnostic)
-- - Encadrement d'un doctorant (ex. d001) → s001 & s002
-- - Collaborateurs externes de "Jean Azi" (s001) 2016–2020 → a2001,a2002,a2004,a2008 (+ pays variés)
-- - Pays en classe A/A* → conférences c1001,c1002,c1003,c1007,c1008,c1009 ; publier_externe pour agrégations
-- - Nb publications par doctorant → publier_laas avec d001,d002,d003,d004
-- - Doctorants ayant soutenu → d002 (2020), d004 (2022)
-- - Doctorants à un seul encadrant → d002, d004
-- - EC par établissement → etablissement_enseignement + enseignant_chercheur
-- - Projets/partenaires → projet_recherche, participation_projet, partenariat_projet
-- ============================================================
