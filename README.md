# 🏥 Forensic Medical Department Database System

A relational database system developed for the Department of Forensic Medicine to replace manual paper-based record management with a secure and efficient computerized solution.

---

## 📌 Project Overview

This project was developed as part of the **Database Systems Mini Project**.

The system manages forensic medical records, including patient information, medico-legal cases, postmortem examinations, evidence, laboratory tests, court reports, and staff information. It demonstrates the complete database development lifecycle, from database design to implementation.

---

## 🎯 Objectives

- Design a normalized relational database
- Store and manage forensic medical records
- Maintain data integrity using constraints
- Improve data retrieval using indexes
- Simplify reporting using SQL views
- Demonstrate database programming using procedures and triggers

---

## 🛠 Technologies Used

- MySQL
- DBeaver
- SQL
- Git & GitHub

---

## 📂 Project Structure

```
Forensic-Database-System/
│
├── Database/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_primary_foreign_keys.sql
│   ├── 04_check_constraints.sql
│   ├── 05_indexes.sql
│   ├── 06_views.sql
│   ├── 07_stored_procedures.sql
│   ├── 08_triggers.sql
│   ├── 09_sample_data.sql
│   └── 10_sample_queries.sql
│
├── ERD/
│
├── Screenshots/
│
├── Report/
│
└── README.md
```

---

## 🗄 Database Modules

The system contains the following modules.

- Patient Management
- Case Management
- Postmortem Management
- Evidence Management
- Laboratory Test Management
- Court Report Management
- Staff Management
- User Authentication

---

## 🏗 Database Design

The database consists of multiple related tables connected using primary and foreign keys.

Main entities include:

- Patients
- Cases
- Doctors
- Staff
- Postmortem
- Evidence
- LaboratoryTests
- CourtReports
- Users
- Orders (if applicable)

---

## ⚙ Features Implemented

- ✔ Database creation
- ✔ Table creation
- ✔ Primary Keys
- ✔ Foreign Keys
- ✔ CHECK Constraints
- ✔ UNIQUE Constraints
- ✔ DEFAULT Constraints
- ✔ Indexes
- ✔ SQL Views
- ✔ Stored Procedures
- ✔ Triggers
- ✔ Sample Data
- ✔ SQL Queries

---

## 🚀 How to Run



3. Execute the SQL files in the following order.

```
01_create_database.sql
02_create_tables.sql
03_primary_foreign_keys.sql
04_check_constraints.sql
05_indexes.sql
06_views.sql
07_stored_procedures.sql
08_triggers.sql
09_sample_data.sql
10_sample_queries.sql
```

---

## 📊 SQL Features Used

- CREATE DATABASE
- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- CHECK
- UNIQUE
- DEFAULT
- INDEX
- VIEW
- STORED PROCEDURE
- TRIGGER
- INSERT
- UPDATE
- DELETE
- SELECT
- JOIN
- GROUP BY
- Aggregate Functions

---

## 📸 Screenshots

Add screenshots of:

- Database tables
- ER Diagram
- Views
- Stored Procedures
- Triggers
- Query Results

---


---

## 📄 License

This project was developed for academic purposes.

```mermaid
erDiagram

    PATIENTS ||--o{ CASES : has
    CASES ||--o{ EVIDENCE : contains
    CASES ||--o{ LABORATORY_TESTS : has
    EVIDENCE ||--o{ LABORATORY_TESTS : tested_in
    CASES ||--|| POSTMORTEMS : has
    DOCTORS ||--o{ POSTMORTEMS : performs
    CASES ||--|| MLEF : has
    DOCTORS ||--o{ MLEF : issues
    CASES ||--o{ INVESTIGATIONS : has
    DOCTORS ||--o{ INVESTIGATIONS : requests
    CASES ||--o{ REFERRALS : has
    DOCTORS ||--o{ REFERRALS : creates
    CASES ||--o{ COURT_REQUESTS : receives
    CASES ||--o{ COURT_REPORTS : has
    DOCTORS ||--o{ COURT_REPORTS : prepares
    CASES ||--o{ DOCUMENTS : stores
    STAFF ||--o{ DOCUMENTS : uploads
    EVIDENCE ||--o{ CHAIN_OF_CUSTODY : tracked_by
    USERS ||--o{ AUDIT_LOGS : generates
    DOCTORS ||--o| USERS : has_account
    STAFF ||--o| USERS : has_account

    PATIENTS {
        int PatientID PK
        string FullName
        string NIC
        date DOB
        string Gender
        string Address
        string ContactNo
    }

    CASES {
        int CaseID PK
        int PatientID FK
        date IncidentDate
        string Status
        string Description
        string CaseType
    }

    DOCTORS {
        int DoctorID PK
        string DoctorName
        string Specialization
        string Qualification
        string LicenseNo
        string ContactNo
        string Email
        string AvailabilityStatus
    }

    EVIDENCE {
        int EvidenceID PK
        int CaseID FK
        string EvidenceType
        string Description
        date CollectedDate
        string StorageLocation
        string CurrentStatus
    }

    LABORATORY_TESTS {
        int TestID PK
        int CaseID FK
        int EvidenceID FK
        string TestType
        date RequestedDate
        string Result
        date ResultDate
        string TestStatus
    }

    COURT_REPORTS {
        int ReportID PK
        int CaseID FK
        int DoctorID FK
        string ReportType
        date SubmissionDate
        string ReportStatus
        string CourtName
    }

    STAFF {
        int StaffID PK
        string StaffName
        string Role
        string Department
        string ContactNo
        string Email
        date EmploymentDate
        string Status
    }

    USERS {
        int UserID PK
        string Username
        string PasswordHash
        string UserRole
        int DoctorID FK
        int StaffID FK
        string AccountStatus
    }

    POSTMORTEMS {
        int PostmortemID PK
        int CaseID FK
        int DoctorID FK
        string PMNumber
        date AutopsyDate
        string Findings
        string CauseOfDeath
        string MannerOfDeath
        string PMStatus
    }

    MLEF {
        int MLEFID PK
        string MLEFNumber
        int CaseID FK
        date IssueDate
        int DoctorID FK
        string PoliceStation
        string Status
    }

    INVESTIGATIONS {
        int InvestigationID PK
        int CaseID FK
        int DoctorID FK
        string InvestigationType
        date RequestedDate
        string Finding
        date ResultDate
        string Status
    }

    REFERRALS {
        int ReferralID PK
        int CaseID FK
        int DoctorID FK
        string ReferredTo
        date ReferralDate
        string Reason
        string ReferralStatus
    }

    COURT_REQUESTS {
        int RequestID PK
        int CaseID FK
        string CourtName
        date RequestDate
        string RequestType
        date DueDate
        string Status
    }

    DOCUMENTS {
        int DocumentID PK
        int CaseID FK
        string DocumentType
        string FilePath
        int StaffID FK
        date UploadDate
        string Description
    }

    CHAIN_OF_CUSTODY {
        int CustodyID PK
        int EvidenceID FK
        string FromPerson
        string ToPerson
        date TransferDate
        string Purpose
        string Remarks
    }

    AUDIT_LOGS {
        int LogID PK
        int UserID FK
        string Action
        string TableName
        int RecordID
        datetime ActionTime
        string Remarks
    }
```
