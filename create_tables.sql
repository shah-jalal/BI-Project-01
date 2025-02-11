CREATE DATABASE HospitalDB;
GO
USE HospitalDB;
GO

-- Patients Table
CREATE TABLE Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    DOB DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Contact VARCHAR(50),
    Address TEXT
);
GO

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL
);
GO

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Specialty VARCHAR(255),
    Contact VARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
);
GO

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
    DoctorID INT FOREIGN KEY REFERENCES Doctors(DoctorID),
    AppointmentDate DATETIME NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')) NOT NULL
);
GO

-- Billing Table
CREATE TABLE Billing (
    BillID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Paid', 'Unpaid', 'Pending')) NOT NULL,
    Date DATE NOT NULL
);
GO

-- Rooms Table
CREATE TABLE Rooms (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    RoomType VARCHAR(100) NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Available', 'Occupied', 'Under Maintenance')) NOT NULL
);
GO

-- Medical Records Table
CREATE TABLE MedicalRecords (
    RecordID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
    Diagnosis TEXT NOT NULL,
    Treatment TEXT NOT NULL,
    AdmissionDate DATE NOT NULL,
    DischargeDate DATE,
    RoomID INT FOREIGN KEY REFERENCES Rooms(RoomID)
);
GO

-- Prescriptions Table
CREATE TABLE Prescriptions (
    PrescriptionID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID INT FOREIGN KEY REFERENCES Appointments(AppointmentID),
    Medicine TEXT NOT NULL,
    Dosage TEXT NOT NULL,
    Instructions TEXT NOT NULL
);
GO