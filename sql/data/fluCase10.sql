DELETE FROM users WHERE MID = 210;
DELETE FROM officevisits WHERE PatientID = 210;
DELETE FROM patients WHERE MID = 210;
DELETE FROM officevisits WHERE id = 6010;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(210,
'Flu10',
'Fodder',
'Raleigh',
'NC',
'27660')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6010,'2014-01-11',9000000000,'Diagnosed with Influenza','1',210);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (910, 6010, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(210, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
