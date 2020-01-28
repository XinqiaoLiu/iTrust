DELETE FROM users WHERE MID = 212;
DELETE FROM officevisits WHERE PatientID = 212;
DELETE FROM patients WHERE MID = 212;
DELETE FROM officevisits WHERE id = 6012;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(212,
'Flu12',
'Fodder',
'Raleigh',
'NC',
'27662')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6012,'2014-01-12',9000000000,'Diagnosed with Influenza','1',212);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (912, 6012, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(212, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
