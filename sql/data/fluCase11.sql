DELETE FROM users WHERE MID = 211;
DELETE FROM officevisits WHERE PatientID = 211;
DELETE FROM patients WHERE MID = 211;
DELETE FROM officevisits WHERE id = 6011;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(211,
'Flu11',
'Fodder',
'Raleigh',
'NC',
'27661')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6011,'2014-01-12',9000000000,'Diagnosed with Influenza','1',211);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (911, 6011, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(211, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
