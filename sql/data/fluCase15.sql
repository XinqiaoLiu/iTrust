DELETE FROM users WHERE MID = 215;
DELETE FROM officevisits WHERE PatientID = 215;
DELETE FROM patients WHERE MID = 215;
DELETE FROM officevisits WHERE id = 6015;

INSERT INTO patients
(MID,
lastName,
firstName,
city,
state,
zip)
VALUES
(215,
'Flu15',
'Fodder',
'Raleigh',
'NC',
'27665')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (6015,'2014-01-13',9000000000,'Diagnosed with Influenza','1',215);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (915, 6015, 487.00);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(215, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
