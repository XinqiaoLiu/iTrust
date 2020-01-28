DELETE FROM users WHERE MID = 230;
DELETE FROM officevisits WHERE PatientID = 230;
DELETE FROM patients WHERE MID = 230;
DELETE FROM officevisits WHERE id = 6030;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(230,
'Flu30',
'Fodder',
'Raleigh',
'NC',
'27630')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6030,'2014-01-19',9000000000,'Diagnosed with Influenza','1',230);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (930, 6030, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(230, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
