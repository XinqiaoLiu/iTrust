DELETE FROM users WHERE MID = 66;
DELETE FROM officevisits WHERE PatientID = 66;
DELETE FROM patients WHERE MID = 66;
DELETE FROM officevisits WHERE id = 3966;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(66,
'Malaria6',
'Fodder',
'Raleigh',
'NC',
'27630')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (3966,'2011-08-02',9000000000,'Diagnosed with Malaria','1',66);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (786, 3966, 84.50);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(66, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
