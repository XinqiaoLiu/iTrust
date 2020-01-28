DELETE FROM users WHERE MID = 201;
DELETE FROM officevisits WHERE PatientID = 201;
DELETE FROM patients WHERE MID = 201;
DELETE FROM officevisits WHERE id = 6001;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(201,
'Flu1',
'Fodder',
'Raleigh',
'NC',
'27651')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6001,'2014-01-10',9000000000,'Diagnosed with Influenza','1',201);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (901, 6001, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(201, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
