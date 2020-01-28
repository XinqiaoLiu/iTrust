DELETE FROM users WHERE MID = 227;
DELETE FROM officevisits WHERE PatientID = 227;
DELETE FROM patients WHERE MID = 227;
DELETE FROM officevisits WHERE id = 6027;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(227,
'Flu27',
'Fodder',
'Raleigh',
'NC',
'27677')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6027,'2014-01-19',9000000000,'Diagnosed with Influenza','1',227);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (927, 6027, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(227, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
