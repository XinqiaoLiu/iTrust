DELETE FROM users WHERE MID = 222;
DELETE FROM officevisits WHERE PatientID = 222;
DELETE FROM patients WHERE MID = 222;
DELETE FROM officevisits WHERE id = 6022;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(222,
'Flu22',
'Fodder',
'Raleigh',
'NC',
'27672')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6022,'2014-01-18',9000000000,'Diagnosed with Influenza','1',222);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (922, 6022, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(222, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
