DELETE FROM users WHERE MID = 217;
DELETE FROM officevisits WHERE PatientID = 217;
DELETE FROM patients WHERE MID = 217;
DELETE FROM officevisits WHERE id = 6017;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(217,
'Flu17',
'Fodder',
'Raleigh',
'NC',
'27667')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6017,'2014-01-17',9000000000,'Diagnosed with Influenza','1',217);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (917, 6017, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(217, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
