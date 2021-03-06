DELETE FROM users WHERE MID = 51;
DELETE FROM officevisits WHERE PatientID = 51;
DELETE FROM patients WHERE MID = 51;
DELETE FROM officevisits WHERE id = 1066;

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
(51,
'John', 
'Donkey1', 
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
'2019-11-21',
84.50,
0,
0,
'B',
'American',
'Male',
'')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (1066,'2019-11-21',9000000000,'Will die today','1',51);


INSERT INTO declaredhcp(PatientID,HCPID) VALUE(51, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
