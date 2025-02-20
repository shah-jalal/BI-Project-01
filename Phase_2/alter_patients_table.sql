--Modify Patients Table to Include New Columns
ALTER TABLE Patients
ADD 
    load_date DATETIME DEFAULT GETDATE(),
    extract_filename NVARCHAR(255);


/* 
Modify the Patients table to enforce uniqueness (e.g., preventing duplicate patients based on Name, DOB, and Contact):
*/

--Add a Unique Constraint to Prevent Duplicates
ALTER TABLE Patients 
ADD CONSTRAINT UQ_Patients UNIQUE (FullName, DOB, Contact);
