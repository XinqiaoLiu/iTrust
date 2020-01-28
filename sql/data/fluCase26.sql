DELETE FROM users WHERE MID = 226;
DELETE FROM officevisits WHERE PatientID = 226;
DELETE FROM patients WHERE MID = 226;
DELETE FROM officevisits WHERE id = 6026;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(226,
'Flu26',
'Fodder',
'Raleigh',
'NC',
'27676')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6026,'2014-01-18',9000000000,'Diagnosed with Influenza','1',226);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (926, 6026, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(226, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
