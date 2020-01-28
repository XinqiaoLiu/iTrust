DELETE FROM users WHERE MID = 202;
DELETE FROM officevisits WHERE PatientID = 202;
DELETE FROM patients WHERE MID = 202;
DELETE FROM officevisits WHERE id = 6002;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(202,
'Flu2',
'Fodder',
'Raleigh',
'NC',
'27652')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6002,'2014-01-10',9000000000,'Diagnosed with Influenza','1',202);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (902, 6002, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(202, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
