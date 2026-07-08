CREATE DATABASE forensic_medical_db;
USE forensic_medical_db;


CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    NIC VARCHAR(12) UNIQUE NOT NULL,
    DOB DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Address VARCHAR(255),
    ContactNo VARCHAR(15)
);

CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    DoctorName VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Qualification VARCHAR(100),
    LicenseNo VARCHAR(50) UNIQUE NOT NULL,
    ContactNo VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    AvailabilityStatus VARCHAR(20) DEFAULT 'Available'
);

CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    StaffName VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    ContactNo VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    EmploymentDate DATE,
    Status VARCHAR(20) DEFAULT 'Active'
);
CREATE TABLE ForensicCase (
    CaseID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    IncidentDate DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'Open',
    Description TEXT,
    CaseType VARCHAR(50) NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);


CREATE TABLE UserAccount (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    UserRole VARCHAR(30) NOT NULL,
    DoctorID INT UNIQUE,
    StaffID INT UNIQUE,
    AccountStatus VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Evidence (
    EvidenceID INT AUTO_INCREMENT PRIMARY KEY,
    CaseID INT NOT NULL,
    EvidenceType VARCHAR(50) NOT NULL,
    Description TEXT,
    CollectedDate DATE NOT NULL,
    StorageLocation VARCHAR(100) NOT NULL,
    CurrentStatus VARCHAR(30) DEFAULT 'Collected',
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID)
);

CREATE TABLE LaboratoryTest (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    CaseID INT NOT NULL,
    EvidenceID INT NOT NULL,
    TestType VARCHAR(50) NOT NULL,
    RequestedDate DATE NOT NULL,
    Result TEXT,
    ResultDate DATE,
    TestStatus VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID),
    FOREIGN KEY (EvidenceID) REFERENCES Evidence(EvidenceID)
);

CREATE TABLE CourtReport (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    CaseID INT NOT NULL,
    DoctorID INT NOT NULL,
    ReportType VARCHAR(50) NOT NULL,
    SubmissionDate DATE,
    ReportStatus VARCHAR(20) DEFAULT 'Pending',
    CourtName VARCHAR(100) NOT NULL,
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Postmortem (
    PostmortemID INT AUTO_INCREMENT PRIMARY KEY,
    CaseID INT UNIQUE NOT NULL,
    DoctorID INT NOT NULL,
    PMNumber VARCHAR(50) UNIQUE NOT NULL,
    AutopsyDate DATE NOT NULL,
    Findings TEXT,
    CauseOfDeath VARCHAR(255),
    MannerOfDeath VARCHAR(30),
    PMStatus VARCHAR(30) DEFAULT 'Scheduled',
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
CREATE TABLE MLEF (
    MLEFID INT AUTO_INCREMENT PRIMARY KEY,
    MLEFNumber VARCHAR(50) UNIQUE NOT NULL,
    CaseID INT UNIQUE NOT NULL,
    IssueDate DATE NOT NULL,
    DoctorID INT NOT NULL,
    PoliceStation VARCHAR(100),
    Status VARCHAR(20) DEFAULT 'Issued',
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
CREATE TABLE Investigation (
    InvestigationID INT AUTO_INCREMENT PRIMARY KEY,
    CaseID INT NOT NULL,
    DoctorID INT NOT NULL,
    InvestigationType VARCHAR(50) NOT NULL,
    RequestedDate DATE NOT NULL,
    Finding TEXT,
    ResultDate DATE,
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Referral (
    ReferralID INT AUTO_INCREMENT PRIMARY KEY,
    CaseID INT NOT NULL,
    DoctorID INT NOT NULL,
    ReferredTo VARCHAR(100) NOT NULL,
    ReferralDate DATE NOT NULL,
    Reason TEXT,
    ReferralStatus VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
CREATE TABLE CourtRequest (
    RequestID INT AUTO_INCREMENT PRIMARY KEY,
    CaseID INT NOT NULL,
    CourtName VARCHAR(100) NOT NULL,
    RequestDate DATE NOT NULL,
    RequestType VARCHAR(50) NOT NULL,
    DueDate DATE,
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID)
);

CREATE TABLE Document (
    DocumentID INT AUTO_INCREMENT PRIMARY KEY,
    CaseID INT NOT NULL,
    DocumentType VARCHAR(50) NOT NULL,
    FilePath VARCHAR(255) NOT NULL,
    StaffID INT NOT NULL,
    UploadDate DATE NOT NULL,
    Description TEXT,
    FOREIGN KEY (CaseID) REFERENCES ForensicCase(CaseID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE ChainOfCustody (
    CustodyID INT AUTO_INCREMENT PRIMARY KEY,
    EvidenceID INT NOT NULL,
    FromPerson VARCHAR(100) NOT NULL,
    ToPerson VARCHAR(100) NOT NULL,
    TransferDate DATE NOT NULL,
    Purpose VARCHAR(100) NOT NULL,
    Remarks TEXT,
    FOREIGN KEY (EvidenceID) REFERENCES Evidence(EvidenceID)
);

CREATE TABLE AuditLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Action VARCHAR(50) NOT NULL,
    TableName VARCHAR(50) NOT NULL,
    RecordID INT,
    ActionTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    Remarks TEXT,
    FOREIGN KEY (UserID) REFERENCES UserAccount(UserID)
);
ALTER TABLE Patient
ADD CONSTRAINT chk_patient_gender
CHECK (Gender IN ('Male', 'Female', 'Other'));

ALTER TABLE Doctor
ADD CONSTRAINT chk_doctor_availability
CHECK (AvailabilityStatus IN ('Available', 'Busy', 'On Leave'));

ALTER TABLE ForensicCase
ADD CONSTRAINT chk_case_status
CHECK (Status IN ('Open', 'Closed', 'Pending'));

ALTER TABLE ForensicCase
ADD CONSTRAINT chk_case_type
CHECK (CaseType IN (
'Trauma Patient',
'Detainee',
'Deceased',
'Age Estimation',
'Domestic Abuse',
'Sexual Abuse',
'Postmortem'
));
ALTER TABLE Staff
ADD CONSTRAINT chk_staff_status
CHECK (Status IN ('Active', 'Inactive'));

ALTER TABLE UserAccount
ADD CONSTRAINT chk_user_role
CHECK (UserRole IN ('Admin', 'Doctor', 'Staff'));

ALTER TABLE UserAccount
ADD CONSTRAINT chk_account_status
CHECK (AccountStatus IN ('Active', 'Inactive', 'Locked'));

ALTER TABLE Evidence
ADD CONSTRAINT chk_evidence_status
CHECK (
    CurrentStatus IN (
        'Collected',
        'In Lab',
        'Under Analysis',
        'Stored',
        'Sent to Court',
        'Returned'
    )
);

ALTER TABLE LaboratoryTest
ADD CONSTRAINT chk_test_status
CHECK (TestStatus IN ('Pending', 'Completed', 'Cancelled'));

ALTER TABLE Postmortem
ADD CONSTRAINT chk_manner_of_death
CHECK (
    MannerOfDeath IN (
        'Natural',
        'Accidental',
        'Suicidal',
        'Homicidal',
        'Undetermined'
    )
);

ALTER TABLE Postmortem
ADD CONSTRAINT chk_pm_status
CHECK (
    PMStatus IN (
        'Scheduled',
        'Completed',
        'Report Pending',
        'Report Issued'
    )
);

ALTER TABLE MLEF
ADD CONSTRAINT chk_mlef_status
CHECK (Status IN ('Issued', 'Pending', 'Completed'));

ALTER TABLE Investigation
ADD CONSTRAINT chk_investigation_status
CHECK (Status IN ('Pending', 'Completed'));

ALTER TABLE Referral
ADD CONSTRAINT chk_referral_status
CHECK (
    ReferralStatus IN (
        'Pending',
        'Completed',
        'Cancelled'
    )
);

ALTER TABLE CourtRequest
ADD CONSTRAINT chk_request_status
CHECK (
    Status IN (
        'Pending',
        'Completed',
        'Overdue'
    )
);
