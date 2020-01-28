DELETE FROM users WHERE MID = 60;
DELETE FROM officevisits WHERE PatientID = 60;
DELETE FROM patients WHERE MID = 60;
DELETE FROM officevisits WHERE id = 3560;

INSERT INTO patients
(MID,
lastName,
firstName,
email,
address1,
address2,
city,
state,
zip,
phone,
eName,
ePhone,
iCName,
iCAddress1,
iCAddress2,
iCCity,
ICState,
iCZip,
iCPhone,
iCID,
dateofbirth,
mothermid,
fathermid,
bloodtype,
ethnicity,
gender,
topicalnotes)
VALUES
(60,
'Malaria0',
'Fodder',
'prepatient@gmail.com',
'prepatient address line 1',
'prepatient address line 2',
'Raleigh',
'NC',
'27607',
'123-456-7899',
'prepatient eNmae',
'999-999-9999',
'prepatient icName',
'prepatient icAddress1',
'prepatient icAddress1',
'New York',
'NY',
'28215',
'888-888-8888',
'XXXXXXXX',
'1999-03-18',
0,
0,
'A',
'American',
'Male',
'malaria addition 0')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (3560, '2011-07-20',9000000000,'Diagnosed with Malaria','1',60);

INSERT INTO ovdiagnosis(Id,VisitID,ICDCode)
Values (780, 3960, 84.50);

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(60, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
