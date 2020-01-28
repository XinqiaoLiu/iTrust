DELETE FROM users WHERE MID = 61;
DELETE FROM officevisits WHERE PatientID = 61;
DELETE FROM patients WHERE MID = 61;
DELETE FROM officevisits WHERE id = 3961;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(61,
'Malaria1',
'Fodder',
'Raleigh',
'NC',
'27617')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (3961,'2011-07-21',9000000000,'Diagnosed with Malaria','1',61);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (781, 3961, 84.50);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(61, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
