--Create a log table to track ETL activity:
USE HospitalDB;
GO
CREATE TABLE ETL_Log (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    PreviousRowCount INT,
    CurrentRowCount INT,
    TotalRowsLoaded INT,
    FileName VARCHAR(255),
    LoadDate DATETIME DEFAULT GETDATE(),
    AdditionalInfo VARCHAR(500)
);
