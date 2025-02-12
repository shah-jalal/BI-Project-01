/*** Insert Dummy Data ***/

INSERT INTO Departments (DepartmentName)
VALUES ('Cardiology'), ('Neurology'), ('Orthopedics'), ('Pediatrics'), ('General Surgery');
GO

INSERT INTO Doctors (Name, Specialty, Contact, DepartmentID)
VALUES 
('Dr. Smith', 'Cardiology', '123-456-7890', 1),
('Dr. Johnson', 'Neurology', '987-654-3210', 2),
('Dr. Brown', 'Orthopedics', '555-666-7777', 3),
('Dr. Taylor', 'Pediatrics', '333-222-1111', 4),
('Dr. Wilson', 'General Surgery', '777-888-9999', 5);
GO

INSERT INTO Patients (FullName, DOB, Gender, Contact, Address)
VALUES 
('John Doe', '1985-05-15', 'Male', '111-222-3333', '123 Main St'),
('Jane Smith', '1990-08-22', 'Female', '444-555-6666', '456 Elm St'),
('Michael Johnson', '1982-09-10', 'Male', '777-888-9999', '789 Oak St'),
('Jonathon Hale', '1997-05-15', 'Male', '123-456-7810', '1260 Club DR'),
('Andy Rodger', '1995-09-25', 'Male', '456-789-1260', '700 Jefferson St'),
('Josh Allen', '1987-02-16', 'Male', '789-120-4444', '578 Oak Grove');
GO

INSERT INTO Prescriptions (AppointmentID, Medicine, Dosage, Instructions)
VALUES
(1, 'Paracetamol', '500mg', 'Take one tablet every 6 hours with water'),
(2, 'Amoxicillin', '250mg', 'Take two capsules twice daily after food'),
(3, 'Ibuprofen', '400mg', 'Take one tablet every 8 hours as needed for pain'),
(4, 'Metformin', '850mg', 'Take one tablet before breakfast daily'),
(5, 'Atorvastatin', '10mg', 'Take one tablet at bedtime with food'),
(6, 'Losartan', '50mg', 'Take one tablet in the morning daily'),
(7, 'Omeprazole', '20mg', 'Take one capsule before meals for 14 days'),
(8, 'Levothyroxine', '100mcg', 'Take on an empty stomach in the morning'),
(9, 'Aspirin', '81mg', 'Take one tablet daily with a full glass of water'),
(10, 'Ciprofloxacin', '500mg', 'Take one tablet twice daily for 7 days'),
(11, 'Cetirizine', '10mg', 'Take one tablet daily for allergies'),
(12, 'Metoprolol', '25mg', 'Take one tablet twice daily with food'),
(13, 'Doxycycline', '100mg', 'Take one capsule twice daily for 10 days'),
(14, 'Prednisone', '5mg', 'Take one tablet daily with food for 7 days'),
(15, 'Hydrochlorothiazide', '12.5mg', 'Take one tablet in the morning daily');

-- Generate 50 Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status)
SELECT TOP 50 
    p.PatientID, d.DoctorID, 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 30, GETDATE()), 
    CASE (ABS(CHECKSUM(NEWID())) % 3) 
        WHEN 0 THEN 'Scheduled' 
        WHEN 1 THEN 'Completed' 
        ELSE 'Cancelled' 
    END
FROM Patients p CROSS JOIN Doctors d;
GO

-- Generate 50 Billing Records
INSERT INTO Billing (PatientID, Amount, PaymentStatus, Date)
SELECT TOP 50 
    p.PatientID, 
    RAND() * 500 + 100, 
    CASE (ABS(CHECKSUM(NEWID())) % 3) 
        WHEN 0 THEN 'Paid' 
        WHEN 1 THEN 'Unpaid' 
        ELSE 'Pending' 
    END,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 30, GETDATE())
FROM Patients p;
GO

-- Generate 50 Medical Records
INSERT INTO MedicalRecords (PatientID, Diagnosis, Treatment, AdmissionDate, DischargeDate, RoomID)
SELECT TOP 50 
    p.PatientID, 
    'Diagnosis ' + CAST(ROW_NUMBER() OVER (ORDER BY p.PatientID) AS VARCHAR),
    'Treatment ' + CAST(ROW_NUMBER() OVER (ORDER BY p.PatientID) AS VARCHAR),
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 60, GETDATE()),
    CASE WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0 THEN DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 30, GETDATE()) ELSE NULL END,
    NULL
FROM Patients p;
GO

-- Generate 50 Room Assignments
INSERT INTO Rooms (RoomType, Status)
SELECT TOP 50 
    CASE (ABS(CHECKSUM(NEWID())) % 3) 
        WHEN 0 THEN 'General' 
        WHEN 1 THEN 'ICU' 
        ELSE 'Private' 
    END,
    CASE (ABS(CHECKSUM(NEWID())) % 3) 
        WHEN 0 THEN 'Available' 
        WHEN 1 THEN 'Occupied' 
        ELSE 'Under Maintenance' 
    END
FROM sys.all_objects;
GO