DELETE FROM users WHERE MID = 64;
DELETE FROM officevisits WHERE PatientID = 64;
DELETE FROM patients WHERE MID = 64;
DELETE FROM officevisits WHERE id = 3964;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(64,
'Malaria4',
'Fodder',
'Raleigh',
'NC',
'27627')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (3964,'2011-07-27',9000000000,'Diagnosed with Malaria','1',64);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (784, 3964, 84.50);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(64, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
