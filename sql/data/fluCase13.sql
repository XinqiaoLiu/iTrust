DELETE FROM users WHERE MID = 213;
DELETE FROM officevisits WHERE PatientID = 213;
DELETE FROM patients WHERE MID = 213;
DELETE FROM officevisits WHERE id = 6013;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(213,
'Flu13',
'Fodder',
'Raleigh',
'NC',
'27663')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6013,'2014-01-13',9000000000,'Diagnosed with Influenza','1',213);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (913, 6013, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(213, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
