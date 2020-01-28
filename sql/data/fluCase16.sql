DELETE FROM users WHERE MID = 216;
DELETE FROM officevisits WHERE PatientID = 216;
DELETE FROM patients WHERE MID = 216;
DELETE FROM officevisits WHERE id = 6016;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(216,
'Flu16',
'Fodder',
'Raleigh',
'NC',
'27666')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6016,'2014-01-17',9000000000,'Diagnosed with Influenza','1',216);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (916, 6016, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(216, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
