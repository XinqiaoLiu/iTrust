DELETE FROM users WHERE MID = 204;
DELETE FROM officevisits WHERE PatientID = 204;
DELETE FROM patients WHERE MID = 204;
DELETE FROM officevisits WHERE id = 6004;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(204,
'Flu4',
'Fodder',
'Raleigh',
'NC',
'27654')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6004,'2014-01-10',9000000000,'Diagnosed with Influenza','1',204);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (904, 6004, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(204, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
