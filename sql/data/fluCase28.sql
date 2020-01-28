DELETE FROM users WHERE MID = 228;
DELETE FROM officevisits WHERE PatientID = 228;
DELETE FROM patients WHERE MID = 228;
DELETE FROM officevisits WHERE id = 6028;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(228,
'Flu28',
'Fodder',
'Raleigh',
'NC',
'27678')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6028,'2014-01-19',9000000000,'Diagnosed with Influenza','1',228);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (928, 6028, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(228, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
