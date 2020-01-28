DELETE FROM users WHERE MID = 218;
DELETE FROM officevisits WHERE PatientID = 218;
DELETE FROM patients WHERE MID = 218;
DELETE FROM officevisits WHERE id = 6018;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(218,
'Flu18',
'Fodder',
'Raleigh',
'NC',
'27668')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6018,'2014-01-17',9000000000,'Diagnosed with Influenza','1',218);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (918, 6018, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(218, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
