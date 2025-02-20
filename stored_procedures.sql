/*================================================
CREATE STORE PROCEDURES
-- ===============================================*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*------------------------------------------------------------------------------------------------------------------------------
Name				: ScheduleAppointment 
Description			: Insert data to Schedule a new Appointments
Input Parameters	: @PatientID, @DoctorID, @AppointmentDate & @Status
Validations			: If you try to insert an invalid status (Pending, Rescheduled, etc.), SQL Server will 
					  throw an error because the Status column is restricted to only accept: (Scheduled, Completed, Cancelled)
Version:			: 1.0
-------------------------------------------------------------------------------------------------------------------------------*/

-- Stored Procedure to Schedule an Appointment
CREATE PROCEDURE ScheduleAppointment
    @PatientID INT,
    @DoctorID INT,
    @AppointmentDate DATETIME,
    @Status VARCHAR(20)
AS
BEGIN
    IF @Status NOT IN ('Scheduled', 'Completed', 'Cancelled')
    BEGIN
        PRINT 'Invalid Status Value';
        RETURN;
    END
    
    INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status)
    VALUES (@PatientID, @DoctorID, @AppointmentDate, @Status);
    
    PRINT 'Appointment Scheduled Successfully';
END;
GO

/*---------------------------------------------------------------------------------------------------------
Name				: GetPatientHistory 
Description			: Retrieves the complete medical history of a patient
Input Parameters	: @PatientID
Version:			: 1.0
----------------------------------------------------------------------------------------------------------*/

-- Stored Procedure to Retrieve Patient History
CREATE PROCEDURE GetPatientHistory
    @PatientID INT
AS
BEGIN
    SELECT 
        p.FullName, 
        a.AppointmentDate, 
        d.Name AS DoctorName, 
        m.Diagnosis, 
        m.Treatment
    FROM Patients p
    JOIN Appointments a ON p.PatientID = a.PatientID
    JOIN Doctors d ON a.DoctorID = d.DoctorID
    LEFT JOIN MedicalRecords m ON p.PatientID = m.PatientID
    WHERE p.PatientID = @PatientID
    ORDER BY a.AppointmentDate DESC;
END;
GO

/*---------------------------------------------------------------------------------------------------------
Name				: GetPatientPrescriptions
Description			: Retrieves a patient's prescription history (including doctor details, appointment date, and prescribed medicines)
Input Parameters	: @PatientID
Version:			: 1.0
Author				: Shah Jalal
Create Date			: 02/17/2025
----------------------------------------------------------------------------------------------------------*/

-- -- Stored Procedure to Retrieve Patient Prescription History
CREATE PROCEDURE GetPatientPrescriptions
    @PatientID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.PrescriptionID, 
        pa.FullName AS PatientName, 
        d.Name AS PrescribedBy, 
        p.Medicine, 
        p.Dosage, 
        p.Instructions, 
        a.AppointmentDate
    FROM Prescriptions p
    JOIN Appointments a ON p.AppointmentID = a.AppointmentID
    JOIN Patients pa ON a.PatientID = pa.PatientID
    JOIN Doctors d ON a.DoctorID = d.DoctorID
    WHERE a.PatientID = @PatientID
    ORDER BY a.AppointmentDate DESC;
END;
GO

/*---------------------------------------------------------------------------------------------------------
Name				: AddPrescription
Description			: This procedure adds a new prescription for an appointment
Input Parameters	: @AppointmentID, @Medicine, @Dosage, @Instructions
Version:			: 1.0
Author				: Shah Jalal
Create Date			: 02/17/2025
----------------------------------------------------------------------------------------------------------*/

-- Stored Procedure to Add a New Prescription for an Appointment
CREATE PROCEDURE AddPrescription
    @AppointmentID INT,
    @Medicine TEXT,
    @Dosage TEXT,
    @Instructions TEXT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert new prescription
    INSERT INTO Prescriptions (AppointmentID, Medicine, Dosage, Instructions)
    VALUES (@AppointmentID, @Medicine, @Dosage, @Instructions);

    PRINT 'Prescription Added Successfully';
END;
GO

/*---------------------------------------------------------------------------------------------------------
Name				: GetPrescriptionsByDateRange
Description			: This procedure retrieves prescriptions issued within a specified date range
Input Parameters	: @StartDate, @EndDate
Version:			: 1.0
Author				: Shah Jalal
Create Date			: 02/17/2025
----------------------------------------------------------------------------------------------------------*/

-- Stored Procedure to Retrieves Pescriptions Based on a Date Range
CREATE PROCEDURE GetPrescriptionsByDateRange
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        P.PrescriptionID, 
        Pa.FullName AS PatientName, 
        D.Name AS PrescribedBy, 
        P.Medicine, 
        P.Dosage, 
        P.Instructions, 
        A.AppointmentDate
    FROM Prescriptions P
    JOIN Appointments A ON P.AppointmentID = A.AppointmentID
    JOIN Patients Pa ON A.PatientID = Pa.PatientID
    JOIN Doctors D ON A.DoctorID = D.DoctorID
    WHERE A.AppointmentDate BETWEEN @StartDate AND @EndDate
    ORDER BY A.AppointmentDate;
END;
GO