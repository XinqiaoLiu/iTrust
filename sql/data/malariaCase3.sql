DELETE FROM users WHERE MID = 63;
DELETE FROM officevisits WHERE PatientID = 63;
DELETE FROM patients WHERE MID = 63;
DELETE FROM officevisits WHERE id = 3963;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(63,
'Malaria3',
'Fodder',
'Raleigh',
'NC',
'27626')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (3963,'2011-07-30',9000000000,'Diagnosed with Malaria','1',63);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (783, 3963, 84.50);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(63, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
