DELETE FROM users WHERE MID = 205;
DELETE FROM officevisits WHERE PatientID = 205;
DELETE FROM patients WHERE MID = 205;
DELETE FROM officevisits WHERE id = 6005;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(205,
'Flu5',
'Fodder',
'Raleigh',
'NC',
'27655')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6005,'2014-01-11',9000000000,'Diagnosed with Influenza','1',205);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (905, 6005, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(205, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
