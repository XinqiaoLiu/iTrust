DELETE FROM users WHERE MID = 62;
DELETE FROM officevisits WHERE PatientID = 62;
DELETE FROM patients WHERE MID = 62;
DELETE FROM officevisits WHERE id = 3962;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(62,
'Malaria2',
'Fodder',
'Raleigh',
'NC',
'27620')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (3962,'2011-07-24',9000000000,'Diagnosed with Malaria','1',62);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (782, 3962, 84.50);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(62, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
