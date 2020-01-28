DELETE FROM users WHERE MID = 203;
DELETE FROM officevisits WHERE PatientID = 203;
DELETE FROM patients WHERE MID = 203;
DELETE FROM officevisits WHERE id = 6003;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(203,
'Flu3',
'Fodder',
'Raleigh',
'NC',
'27653')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6003,'2014-01-10',9000000000,'Diagnosed with Influenza','1',203);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (903, 6003, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(203, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
