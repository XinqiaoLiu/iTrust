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
(411,
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
0,
0,
'B',
'American',
'Male',
'')
 ON DUPLICATE KEY UPDATE MID = MID;

 INSERT INTO users(MID, password, role, sQuestion, sAnswer) 
    VALUES (411, 'feec52d5271de7b91d83cf8d16cf90117bafa0b170341d6ff4d62c3c35b4c8cb', 'prepatient', 'what is your favorite color?', 'purple')
 ON DUPLICATE KEY UPDATE MID = MID;