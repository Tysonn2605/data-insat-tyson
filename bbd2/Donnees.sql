INSERT INTO Personnel VALUES
('P001','Azi','Jean',2015,'1980-02-12','Toulouse'),
('P002','Martin','Claire',2017,'1985-05-10','Toulouse'),
('P003','Dupont','Louis',2012,'1978-09-22','Toulouse'),
('P004','Nguyen','An',2019,'1994-12-01','Paris'),
('P005','Tran','Minh',2020,'1995-06-15','Lyon'),
('P006','Durand','Elise',2016,'1983-04-09','Bordeaux');

INSERT INTO Chercheur VALUES
('P001','Prof'),
('P002','MCF'),
('P003','Prof'),
('P006','MCF');

INSERT INTO Doctorant VALUES
('D001','P004',2019,2023),
('D002','P005',2020,NULL),
('D003','P005',2021,NULL);

INSERT INTO Encadrement VALUES
('D001','P001'),
('D001','P002'),
('D002','P003'),
('D003','P002'),
('D003','P006');


INSERT INTO Conference VALUES
(101,'ICML',2019,'A'),
(102,'NeurIPS',2020,'A'),
(103,'ECML',2018,'B'),
(104,'IJCNN',2017,'C');

INSERT INTO Article VALUES
(201,'Deep Learning Models',101),
(202,'Robotics Control',102),
(203,'Data Mining Techniques',103),
(204,'Neural Networks Advances',102),
(205,'Sensor Fusion',104);

INSERT INTO PublierLAAS VALUES
('P001',201),
('P002',201),
('P001',202),
('P003',202),
('P003',203),
('P002',204),
('P006',205);

INSERT INTO LaboratoireExterne VALUES
(301,'MIT CSAIL','USA'),
(302,'EPFL LTS2','Suisse'),
(303,'AIST Tokyo','Japon'),
(304,'TU Berlin','Allemagne');

INSERT INTO AuteurExterne VALUES
(401,'Smith','John','john@mit.edu',301),
(402,'Keller','Anne','anne@epfl.ch',302),
(403,'Tanaka','Yuji','yuji@aist.jp',303),
(404,'Müller','Hans','hans@tu-berlin.de',304);

INSERT INTO PublierExterne VALUES
(401,201),
(402,202),
(403,203),
(404,204),
(401,205);

INSERT INTO EtablissementEnseignement VALUES
(501,'INSA Toulouse','INSA','Toulouse'),
(502,'Université Paul Sabatier','UPS','Toulouse'),
(503,'ENSTA Paris','ENSTA','Paris');



INSERT INTO EnseignantChercheur VALUES
('P001','E3',501),
('P002','E1',502),
('P003','E2',501),
('P006','E1',503);

INSERT INTO ProjetRecherche VALUES
(601,'AI Robotics','AIROB',2018,3,300000,150000,'P001'),
(602,'Deep Vision','DEEPV',2019,4,450000,200000,'P002'),
(603,'Smart Sensors','SENS',2020,2,150000,80000,'P003');

INSERT INTO ParticipationProjet VALUES
('P001',601),
('P002',601),
('P003',602),
('P001',602),
('P006',603),
('P002',603);

INSERT INTO Partenaire VALUES
(701,'Google AI','USA'),
(702,'Siemens Research','Allemagne'),
(703,'Sony R&D','Japon');

INSERT INTO PartenariatProjet VALUES
(701,601),
(702,602),
(703,603),
(701,602),
(703,601);
