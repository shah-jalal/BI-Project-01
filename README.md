# 🏥 Hospital Management System - SQL Database

## 📌 Project Overview
The **Hospital Management System** is a relational database designed to efficiently manage patient records, doctor schedules, appointments, billing, and medical history. The project is built using **Microsoft SQL Server** and implements best practices such as stored procedures, views, constraints, and dummy data for testing.

## 📂 Project Structure
```
HospitalDB/
├── SQL_Scripts/
│   ├── create_tables.sql  # Defines all tables and relationships
│   ├── insert_dummy_data.sql  # Populates tables with sample data
│   ├── stored_procedures.sql  # Contains stored procedures for automation
│   ├── views.sql  # SQL Views for reporting
│   ├── queries.sql  # Sample queries for insights
│   ├── README.md  # Project documentation
```

## 🛠 Features
- **Patient Management:** Store patient details, medical history, and assigned doctors.
- **Doctor Scheduling:** Manage doctor availability and track appointments.
- **Appointment Booking:** Schedule, complete, or cancel patient appointments.
- **Billing System:** Track payments, due amounts, and billing statuses.
- **Medical Records:** Store diagnosis and treatment history.
- **Automated Reports:** Use views for doctor-wise appointments and patient department-wise statistics.

---

## 📌 Database Schema
### **Tables Overview**
- **Patients**: Stores patient information.
- **Doctors**: Stores doctor details and their specialties.
- **Appointments**: Manages doctor-patient appointments.
- **Billing**: Tracks payment status for patients.
- **MedicalRecords**: Stores diagnosis and treatments.
- **Departments**: Lists hospital departments.
- **Rooms**: Tracks hospital room availability.

---

## 🚀 Setup Instructions
### **1️⃣ Install SQL Server**
Ensure you have **Microsoft SQL Server** installed and running.

### **2️⃣ Clone the Repository**
```sh
git clone https://github.com/shah-jalal/BI-Project-01.git       
cd BI-Project-01
```

### **3️⃣ Create Database & Tables**
Run the following in SQL Server Management Studio (SSMS):
```sql
CREATE DATABASE HospitalDB;
USE HospitalDB;
```
Execute the **create_tables.sql** script to generate tables:
```sql
-- Run this inside SSMS
:load SQL_Scripts/create_tables.sql
```

### **4️⃣ Insert Dummy Data**
```sql
:load SQL_Scripts/insert_dummy_data.sql
```

### **5️⃣ Create Stored Procedures & Views**
```sql
:load SQL_Scripts/stored_procedures.sql
:load SQL_Scripts/views.sql
```

### **6️⃣ Run Sample Queries**
```sql
:load SQL_Scripts/queries.sql
```

---

## 📊 Usage & Reporting
### **Stored Procedures**
#### **Schedule a New Appointment**
```sql
EXEC ScheduleAppointment @PatientID = 5, @DoctorID = 2, @AppointmentDate = '2025-02-15 10:30:00', @Status = 'Scheduled';
```
#### **Retrieve Patient Medical History**
```sql
EXEC GetPatientHistory @PatientID = 5;
```

### **Views for Reporting**
#### **Doctor-wise Appointments Report**
```sql
SELECT * FROM Appointments;
```
#### **Patients Admitted per Department**
```sql
SELECT * FROM PatientsPerDepartment;
```

---

## 📝 Sample Queries
### **Find Top 5 Busiest Doctors**
```sql
SELECT TOP 5 * FROM DoctorAppointments ORDER BY TotalAppointments DESC;
```
### **List Departments with Least Admitted Patients**
```sql
SELECT * FROM PatientsPerDepartment ORDER BY TotalPatientsAdmitted DESC;
```
### **Check Outstanding Bills**
```sql
SELECT * FROM Billing WHERE PaymentStatus = 'Unpaid';
```

---

## 🤝 Contribution Guidelines
1. Fork the repository & clone it.
2. Create a new branch (`feature/your-feature-name`).
3. Commit your changes with meaningful commit messages.
4. Push the branch and create a Pull Request.

---

## 📄 License
This project is **open-source** and available under the **MIT License**.

---

## 📧 Contact & Support
- **Author:** Shah Jalal
- **GitHub:** [@shah-jalal](https://github.com/shah-jalal)
- **Email:** shah7097tn@gmail.com

