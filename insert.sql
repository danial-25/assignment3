INSERT INTO Country (cname, population)
VALUES 
('Kazakhstan', 19000000),
('France', 70000000),
('Germany', 80000000),
('Japan', 12000000),
('UK', 67000000),
('Italy', 60000000),
('Spain', 47000000),
('Australia', 25000000),
('China', 2000000000),
('US', 10000000);

INSERT INTO Users (email, first_name, surname, salary, phone, cname)
VALUES 
('doc1@.com', 'Alikhan', 'Bokeikhan', 50000, '1234567890', 'Kazakhstan'),
('doc2@.com', 'Abay', 'Kunanbay', 80000, '1234567891', 'Spain'),
('doc3@.com', 'Baurzhan', 'Baibek', 75000, '1234567892', 'Italy'),
('doc4@.com', 'Gulnaz', 'Zhaksybek', 72000, '1234567893', 'France'),
('doc5@.com', 'Aidar', 'Orazkhan', 82000, '1234567894', 'Germany'),
('doc6@.com', 'Yernar', 'Aidar', 82000, '70000000000', 'Spain'),
('doc7@.com', 'Beknar', 'Kazbekov', 82000, '80000000000', 'Australia'),
('pat1@.com', 'Gulzhan', 'Tursynova', 60000, '1234567895', 'UK'),
('pat2@.com', 'Zhanar', 'Akisheva', 65000, '1234567896', 'France'),
('pat3@.com', 'Saule', 'Bekzhanova', 80000, '1234567897', 'China'),
('serv1@.com', 'Otabek', 'Altyn', 100000, '1234567898', 'Kazakhstan'),
('serv2@.com', 'Denis', 'Ten', 100000, '1234567899' ,'Japan'),
('serv3@.com', 'Bog', 'Dan', 99999, '10000000000', 'France'),
('serv4@.com', 'Donald', 'Duck', 1000000, '10000000001' ,'UK'),
('serv5@.com', 'A', 'Mong', 100000, '10000000002', 'US'),
('serv6@.com', 'Beksultan', 'Khan', 7777777, '10000000003' ,'Kazakhstan');


INSERT INTO Patients (email)
VALUES 
('pat1@.com'),
('pat2@.com'),
('pat3@.com');


INSERT INTO Doctor (email, "degree")
VALUES 
('doc1@.com', 'Phd'),
('doc2@.com', 'PhD'),
('doc3@.com', 'MD'),
('doc4@.com', 'MD'),
('doc5@.com', 'PhD'),
('doc6@.com', 'MD'),
('doc7@.com', 'PhD');


INSERT INTO DiseaseType ("id", description)
VALUES 
(1, 'infectious diseases'),
(2, 'virology'),
(3, 'cardiovascular diseases'),
(4, 'respiratory diseases'),
(5, 'neurological disorders'),
(6, 'cancers'),
(7, 'endocrine diseases'),
(8, 'skin diseases'),
(9, 'mental health disorders'),
(10, 'gastrointestinal diseases');



INSERT INTO Disease (disease_code, pathogen, description, disease_id)
VALUES 
('D1', 'virus', 'covid-19', 1),
('D2', 'virus', ' HIV', 2),
('D3', 'virus', 'Flu', 1),
('D4', 'bacteria', 'Lyme Disease', 1),
('D5', 'virus', 'Ebola', 1),
('D6', 'bacteria', 'abc', 1),
('D7', 'virus', 'smthng', 7),
('D8', 'bacteria', 'nthng', 1),
('D9', NULL, 'stomachache', 10),
('D10', NULL, 'epilepsy', 9);


INSERT INTO Discover (cname, disease_code, first_enc_date)
VALUES 
('Kazakhstan', 'D1', '2019-12-01'),
('Japan', 'D2', '2014-07-14'),
('France', 'D3', '2017-09-10'),
('Germany', 'D4', '2016-03-20'),
('Japan', 'D5', '2015-01-25'),
('Italy', 'D6', '2016-01-25'),
('Spain', 'D7', '2017-01-25'),
('UK', 'D8', '2018-01-25');

INSERT INTO PatientDisease (email, disease_code)
VALUES 
('pat1@.com', 'D1'),
('pat1@.com', 'D3'),
('pat2@.com', 'D1'),
('pat2@.com', 'D6'),
('pat3@.com', 'D5'),
('pat3@.com', 'D7'),
('pat2@.com', 'D8'),
('pat3@.com', 'D1'),
('pat1@.com', 'D4'),
('pat1@.com', 'D2');

INSERT INTO PublicServant (email, department)
VALUES 
('serv1@.com', 'Education'),
('serv2@.com', 'Healthcare'),
('serv3@.com', 'Healthcare'),
('serv4@.com', 'Healthcare'),
('serv5@.com', 'Science'),
('serv6@.com', 'Education');


INSERT INTO Specialize (disease_id, email)
VALUES 
(1, 'doc1@.com'), 
(2, 'doc1@.com'), 
(3, 'doc2@.com'), 
(4, 'doc2@.com'), 
(5, 'doc3@.com'), 
(6, 'doc3@.com'),
(7, 'doc4@.com'),
(8, 'doc5@.com'),
(9, 'doc5@.com'),
(2, 'doc6@.com'),
(1, 'doc7@.com'),
(1, 'doc6@.com'),
(9, 'doc7@.com'),
(10, 'doc5@.com');




INSERT INTO Record (email, cname, disease_code, total_deaths, total_patients)
VALUES 
('serv1@.com', 'France', 'D1', 500, 12000),
('serv2@.com', 'Germany', 'D2', 2000, 8000),
('serv3@.com', 'Japan', 'D3', 15000, 30000),
('serv4@.com', 'UK', 'D2', 1000, 7000),
('serv5@.com', 'Italy', 'D1', 2500, 6000),
('serv6@.com', 'Spain', 'D1', 8000, 20000),
('serv3@.com', 'Australia', 'D3', 500, 2000),
('serv4@.com', 'Kazakhstan', 'D4', 100000, 500000),
('serv1@.com', 'China', 'D1', 1000, 12000),
('serv3@.com', 'Kazakhstan', 'D1', 100000, 500000),
('serv2@.com', 'China', 'D1', 1000, 12000),
('serv5@.com', 'Kazakhstan', 'D4', 100000, 500000),
('serv6@.com', 'China', 'D5', 1000, 12000),
('serv2@.com', 'China', 'D6', 1000, 12000);
	





