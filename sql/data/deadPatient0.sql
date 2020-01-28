DELETE FROM users WHERE MID = 50;
DELETE FROM officevisits WHERE PatientID = 50;
DELETE FROM patients WHERE MID = 50;
DELETE FROM officevisits WHERE id = 1065;

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
dateofdeath,
CauseOfDeath,
mothermid,
fathermid,
bloodtype,
ethnicity,
gender, 
topicalnotes)
VALUES
(50,
'John', 
'Donkey', 
'prepatient@gmail.com', 
'prepatient adress line 1', 
'prepatient adress line 2', 
'Champaign', 
'IL', 
'61820', 
'660-541-2300', 
'prepatient eNmae', 
'999-999-9999', 
'prepatient icName', 
'prepatient icAdress1', 
'prepatient icAdress1', 
'New York',
'NY', 
'28215', 
'888-888-8888', 
'XXXXXXXX', 
'1999-03-18',
'2019-11-20',
84.50,
0,
0,
'B',
'American',
'Male',
'')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (1065,'2019-11-20',9000000000,'Will die today','1',50);


INSERT INTO declaredhcp(PatientID,HCPID) VALUE(50, 9000000000)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;
