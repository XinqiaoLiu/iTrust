DELETE FROM users WHERE MID = 232;
DELETE FROM officevisits WHERE PatientID = 232;
DELETE FROM patients WHERE MID = 232;
DELETE FROM officevisits WHERE id = 6032;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(232,
'Flu32',
'Fodder',
'Raleigh',
'NC',
'27632')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6032,'2014-01-20',9000000000,'Diagnosed with Influenza','1',232);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (932, 6032, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(232, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
