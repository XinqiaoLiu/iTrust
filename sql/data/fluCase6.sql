DELETE FROM users WHERE MID = 206;
DELETE FROM officevisits WHERE PatientID = 206;
DELETE FROM patients WHERE MID = 206;
DELETE FROM officevisits WHERE id = 6006;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(206,
'Flu6',
'Fodder',
'Raleigh',
'NC',
'27656')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6006,'2014-01-11',9000000000,'Diagnosed with Influenza','1',206);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (906, 6006, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(206, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
