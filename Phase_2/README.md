# SSIS ETL Package for Patient Data Processing

## Overview
This SSIS package extracts patient data from multiple CSV files, processes and loads it into the `Patients` table in SQL Server while ensuring data integrity, avoiding duplicates, and maintaining a detailed log of the ETL process.

---

## How the Package Works
1. **Extract Data from CSV Files:**  
   - The package iterates through all CSV files in a specified directory using a **Foreach Loop Container**.
   - Each file is dynamically processed using a **Flat File Source**.

2. **Transform Data:**  
   - A **Derived Column Transformation** adds two new fields:
     - `load_date`: The timestamp when data is inserted.
     - `extract_filename`: The name of the file being processed.
   
3. **Handle Duplicate Records:** 
   To prevent duplicate patient records:
   - A **UNIQUE constraint** is added to the `Patients` table on (`FullName`, `DOB`, `Contact`). 
   - A **Lookup Transformation** checks if the patient already exists in the `Patients` table.
   - If a match is found (based on `FullName`, `DOB`, and `Contact`), the record is **excluded** from insertion.
   - Only new records are inserted into the `Patients` table.

4. **Load Data into SQL Server:**  
   - New records are inserted into the `Patients` table using an **OLE DB Destination**.

5. **Logging the ETL Process:**  
   - The package captures key ETL metrics and writes them to the `ETL_Log` table.

---

## Logging Implementation
The `ETL_Log` table records:
- **PreviousRowCount**: Total rows in `Patients` before loading.
- **TotalRowsLoaded**: Number of rows added in the current run.
- **CurrentRowCount**: Total rows after loading.
- **FileName**: The name of the processed CSV file.
- **LoadDate**: The timestamp when the ETL process ran.
- **AdditionalInfo**: Any extra details (e.g., success message, errors).

The package uses an **Execute SQL Task** to insert log details at the end of each ETL run.

---

## Assumptions & Schema Changes
### **Assumptions:**
- CSV files contain consistent, well-structured data with no missing mandatory fields.
- The patient’s identity is uniquely determined by (`FullName`, `DOB`, `Contact`).
- Only new patients should be inserted, no updates to existing records.

### **Schema Changes:**
- Added `load_date` and `extract_filename` columns to the `Patients` table.
- Created `ETL_Log` table to maintain a history of all data loads.

---

## Next Steps
- Implement **error handling** for invalid data.
- Extend the package to support **incremental updates** for existing patients.
- Automate **email notifications** for load status reports.

---

🚀 **This SSIS package ensures efficient, clean, and logged patient data ingestion into SQL Server!**