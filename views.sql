/*-------------------------------------------------------------------------------------
CREATE VIEWS 
---------------------------------------------------------------------------------------
Name		: DoctorAppointments 
Description : Displays the total number of appointments each doctor has
Version		: 1.0
---------------------------------------------------------------------------------------*/

-- View for Doctor-wise Appointments
CREATE VIEW DoctorAppointments AS
SELECT 
    d.Name AS DoctorName, 
    d.Specialty, 
    COUNT(a.AppointmentID) AS TotalAppointments
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.Name, d.Specialty;
GO

/*-----------------------------------------------------------------------------------------------
Name		: PatientsPerDepartment 
Description	: Calculates the total number of patients admitted per department
Version		: 1.0
--------------------------------------------------------------------------------------------------*/

-- View for Patients Admitted per Department
CREATE VIEW PatientsPerDepartment AS
SELECT 
    dep.DepartmentName,
    COUNT(DISTINCT m.PatientID) AS TotalPatientsAdmitted
FROM Departments dep
JOIN Doctors doc ON dep.DepartmentID = doc.DepartmentID
JOIN Appointments a ON doc.DoctorID = a.DoctorID
JOIN MedicalRecords m ON a.PatientID = m.PatientID
GROUP BY dep.DepartmentName;
GO