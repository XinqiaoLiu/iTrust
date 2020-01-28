DELETE FROM users WHERE MID = 208;
DELETE FROM officevisits WHERE PatientID = 208;
DELETE FROM patients WHERE MID = 208;
DELETE FROM officevisits WHERE id = 6008;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(208,
'Flu8',
'Fodder',
'Raleigh',
'NC',
'27658')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6008,'2014-01-12',9000000000,'Diagnosed with Influenza','1',208);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (908, 6008, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(208, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
