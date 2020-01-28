DELETE FROM users WHERE MID = 65;
DELETE FROM officevisits WHERE PatientID = 65;
DELETE FROM patients WHERE MID = 65;
DELETE FROM officevisits WHERE id = 3965;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(65,
'Malaria5',
'Fodder',
'Raleigh',
'NC',
'27627')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (3965,'2011-07-30',9000000000,'Diagnosed with Malaria','1',65);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (785, 3965, 84.50);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(65, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
