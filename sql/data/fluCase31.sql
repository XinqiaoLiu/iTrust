DELETE FROM users WHERE MID = 231;
DELETE FROM officevisits WHERE PatientID = 231;
DELETE FROM patients WHERE MID = 231;
DELETE FROM officevisits WHERE id = 6031;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(231,
'Flu31',
'Fodder',
'Raleigh',
'NC',
'27631')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6031,'2014-01-19',9000000000,'Diagnosed with Influenza','1',231);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (931, 6031, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(231, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
