DELETE FROM users WHERE MID = 200;
DELETE FROM officevisits WHERE PatientID = 200;
DELETE FROM patients WHERE MID = 200;
DELETE FROM officevisits WHERE id = 6000;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(200,
'Flu0',
'Fodder',
'Raleigh',
'NC',
'27650')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6000,'2014-01-10',9000000000,'Diagnosed with Influenza','1',200);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (900, 6000, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(200, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
