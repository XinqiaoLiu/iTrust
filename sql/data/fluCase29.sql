DELETE FROM users WHERE MID = 229;
DELETE FROM officevisits WHERE PatientID = 229;
DELETE FROM patients WHERE MID = 229;
DELETE FROM officevisits WHERE id = 6029;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(229,
'Flu29',
'Fodder',
'Raleigh',
'NC',
'27679')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6029,'2014-01-19',9000000000,'Diagnosed with Influenza','1',229);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (929, 6029, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(229, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
