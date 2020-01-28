DELETE FROM users WHERE MID = 56;
DELETE FROM officevisits WHERE PatientID = 56;
DELETE FROM patients WHERE MID = 56;
DELETE FROM officevisits WHERE id = 1071;

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
DateOfDeath,
CauseOfDeath,
mothermid,
fathermid,
bloodtype,
ethnicity,
gender, 
topicalnotes)
VALUES
(56,
'John', 
'Donkey0', 
'deadpatient0@gmail.com', 
'deadpatient adress line 1', 
'deadpatient adress line 2', 
'Champaign', 
'IL', 
'61820', 
'660-541-2300', 
'deadpatient eNmae', 
'666-666-9999', 
'deadpatient icName', 
'deadpatient icAdress1', 
'deadpatient icAdress1', 
'New York',
'NY', 
'28215', 
'888-888-8888', 
'XXXXXXXX', 
'1999-03-18',
'2019-11-26',
72.00,
0,
0,
'B',
'American',
'Female',
'')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (1071,'2019-11-20',9000000000,'Will die today','1',56);


INSERT INTO declaredhcp(PatientID,HCPID) VALUE(56, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
