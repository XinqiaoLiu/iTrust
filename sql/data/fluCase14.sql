DELETE FROM users WHERE MID = 214;
DELETE FROM officevisits WHERE PatientID = 214;
DELETE FROM patients WHERE MID = 214;
DELETE FROM officevisits WHERE id = 6014;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(214,
'Flu14',
'Fodder',
'Raleigh',
'NC',
'27664')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6014,'2014-01-13',9000000000,'Diagnosed with Influenza','1',214);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (914, 6014, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(214, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
