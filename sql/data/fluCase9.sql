DELETE FROM users WHERE MID = 209;
DELETE FROM officevisits WHERE PatientID = 209;
DELETE FROM patients WHERE MID = 209;
DELETE FROM officevisits WHERE id = 6009;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(209,
'Flu9',
'Fodder',
'Raleigh',
'NC',
'27659')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6009,'2014-01-11',9000000000,'Diagnosed with Influenza','1',209);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (909, 6009, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(209, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
