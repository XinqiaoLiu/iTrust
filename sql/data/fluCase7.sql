DELETE FROM users WHERE MID = 207;
DELETE FROM officevisits WHERE PatientID = 207;
DELETE FROM patients WHERE MID = 207;
DELETE FROM officevisits WHERE id = 6007;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(207,
'Flu6',
'Fodder',
'Raleigh',
'NC',
'27657')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6007,'2014-01-12',9000000000,'Diagnosed with Influenza','1',207);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (907, 6007, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(207, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
