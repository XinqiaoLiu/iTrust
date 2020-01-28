DELETE FROM users WHERE MID = 219;
DELETE FROM officevisits WHERE PatientID = 219;
DELETE FROM patients WHERE MID = 219;
DELETE FROM officevisits WHERE id = 6019;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(219,
'Flu19',
'Fodder',
'Raleigh',
'NC',
'27669')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6019,'2014-01-18',9000000000,'Diagnosed with Influenza','1',219);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (919, 6019, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(219, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
