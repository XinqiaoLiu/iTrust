DELETE FROM users WHERE MID = 225;
DELETE FROM officevisits WHERE PatientID = 225;
DELETE FROM patients WHERE MID = 225;
DELETE FROM officevisits WHERE id = 6025;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(225,
'Flu25',
'Fodder',
'Raleigh',
'NC',
'27675')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6025,'2014-01-18',9000000000,'Diagnosed with Influenza','1',225);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (925, 6025, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(225, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
