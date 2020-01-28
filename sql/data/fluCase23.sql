DELETE FROM users WHERE MID = 223;
DELETE FROM officevisits WHERE PatientID = 223;
DELETE FROM patients WHERE MID = 223;
DELETE FROM officevisits WHERE id = 6023;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(223,
'Flu23',
'Fodder',
'Raleigh',
'NC',
'27673')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6023,'2014-01-18',9000000000,'Diagnosed with Influenza','1',223);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (923, 6023, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(223, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
