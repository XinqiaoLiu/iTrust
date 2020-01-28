DELETE FROM users WHERE MID = 224;
DELETE FROM officevisits WHERE PatientID = 224;
DELETE FROM patients WHERE MID = 224;
DELETE FROM officevisits WHERE id = 6024;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(224,
'Flu24',
'Fodder',
'Raleigh',
'NC',
'27674')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6024,'2014-01-18',9000000000,'Diagnosed with Influenza','1',224);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (924, 6024, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(224, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
