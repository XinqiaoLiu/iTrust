DELETE FROM users WHERE MID = 67;
DELETE FROM officevisits WHERE PatientID = 67;
DELETE FROM patients WHERE MID = 67;
DELETE FROM officevisits WHERE id = 3967;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(67,
'MalariaFirst',
'Fodder',
'Raleigh',
'NC',
'27619')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (3967,'2000-01-06',9000000000,'Diagnosed with Malaria','1',67);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (787, 3967, 84.50);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(67, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
