CREATE TABLE Country (
    cname VARCHAR(50) PRIMARY KEY,
    population BIGINT
);

CREATE TABLE Users (
    email VARCHAR(60) PRIMARY KEY,
    first_name VARCHAR(30),
    surname VARCHAR(40),
    salary INTEGER,
    phone VARCHAR(20),
    cname VARCHAR(50),
    FOREIGN KEY (cname) REFERENCES Country (cname) ON DELETE SET NULL
);

CREATE TABLE Patients (
    email VARCHAR(60) PRIMARY KEY,
    FOREIGN KEY (email) REFERENCES Users (email) ON DELETE CASCADE
);

CREATE TABLE DiseaseType (
    "id" INTEGER PRIMARY KEY,
    description VARCHAR(140)
);

CREATE TABLE Disease (
    disease_code VARCHAR(50) PRIMARY KEY,
    pathogen VARCHAR(20),
    description VARCHAR(140),
    disease_id INTEGER,
    FOREIGN KEY (disease_id) REFERENCES DiseaseType (id) ON DELETE CASCADE
);

CREATE TABLE Discover (
    cname VARCHAR(50),
    disease_code VARCHAR(50),
    first_enc_date DATE,
    PRIMARY KEY (cname, disease_code),
    FOREIGN KEY (cname) REFERENCES Country (cname) ON DELETE CASCADE,
    FOREIGN KEY (disease_code) REFERENCES Disease (disease_code) ON DELETE CASCADE
);

CREATE TABLE PatientDisease (
    email VARCHAR(60),
    disease_code VARCHAR(50),
    PRIMARY KEY (email, disease_code),  
    FOREIGN KEY (email) REFERENCES Users (email) ON DELETE CASCADE,
    FOREIGN KEY (disease_code) REFERENCES Disease (disease_code) ON DELETE CASCADE
);

CREATE TABLE PublicServant (
    email VARCHAR(60) PRIMARY KEY,
    department VARCHAR(50),
    FOREIGN KEY (email) REFERENCES Users (email) ON DELETE CASCADE
);

CREATE TABLE Doctor (
    email VARCHAR(60) PRIMARY KEY,
    "degree" VARCHAR(20),
    FOREIGN KEY (email) REFERENCES Users (email) ON DELETE CASCADE
);

CREATE TABLE Specialize (
    disease_id INTEGER,
    email VARCHAR(60),
    PRIMARY KEY (disease_id, email), 
    FOREIGN KEY (disease_id) REFERENCES DiseaseType ("id") ON DELETE CASCADE,
    FOREIGN KEY (email) REFERENCES Doctor (email) ON DELETE CASCADE
);

CREATE TABLE Record (
    email VARCHAR(60),
    cname VARCHAR(50),
    disease_code VARCHAR(50),
    total_deaths INTEGER,
    total_patients INTEGER,
    PRIMARY KEY (email, cname, disease_code),
    FOREIGN KEY (disease_code) REFERENCES Disease (disease_code) ON DELETE CASCADE,
    FOREIGN KEY (cname) REFERENCES Country (cname) ON DELETE CASCADE,
    FOREIGN KEY (email) REFERENCES PublicServant (email) ON DELETE CASCADE
);

