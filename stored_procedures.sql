/*
-------------------------------------------------------------------------------------------------------------------------------
CREATE STORE PROCEDURES FOR HospitalDB 
-------------------------------------------------------------------------------------------------------------------------------
Name				: ScheduleAppointment (Insert data to Schedule a new Appointments)
Input Parameters	: PatientID, DoctorID, AppointmentDate & Status
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

/*
---------------------------------------------------------------------------------------------------------
Name				: GetPatientHistory (Retrieves the complete medical history of a patient)
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

