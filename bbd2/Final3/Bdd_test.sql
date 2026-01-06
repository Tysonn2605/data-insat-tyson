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





