DELETE FROM users WHERE MID = 220;
DELETE FROM officevisits WHERE PatientID = 220;
DELETE FROM patients WHERE MID = 220;
DELETE FROM officevisits WHERE id = 6020;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(220,
'Flu20',
'Fodder',
'Raleigh',
'NC',
'27670')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6020,'2014-01-18',9000000000,'Diagnosed with Influenza','1',220);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (920, 6020, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(220, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
