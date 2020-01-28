DELETE FROM users WHERE MID = 221;
DELETE FROM officevisits WHERE PatientID = 221;
DELETE FROM patients WHERE MID = 221;
DELETE FROM officevisits WHERE id = 6021;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(221,
'Flu21',
'Fodder',
'Raleigh',
'NC',
'27671')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6021,'2014-01-18',9000000000,'Diagnosed with Influenza','1',221);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (921, 6021, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(221, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
