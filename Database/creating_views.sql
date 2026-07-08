use forensic_medical_db;

CREATE VIEW PatientCaseSummary AS
SELECT 
    p.PatientID,
    p.FullName,
    p.NIC,
    p.Gender,
    p.ContactNo,
    fc.CaseID,
    fc.CaseType,
    fc.IncidentDate,
    fc.Status AS CaseStatus,
    fc.Description
FROM Patient p
JOIN ForensicCase fc
ON p.PatientID = fc.PatientID;

CREATE VIEW EvidenceTracking AS
SELECT
    e.EvidenceID,
    e.EvidenceType,
    e.Description,
    e.CollectedDate,
    e.StorageLocation,
    e.CurrentStatus,
    fc.CaseID,
    fc.CaseType,
    fc.Status AS CaseStatus
FROM Evidence e
JOIN ForensicCase fc
ON e.CaseID = fc.CaseID;


CREATE VIEW PendingCourtReports AS
SELECT
    ReportID,
    CaseID,
    DoctorID,
    ReportType,
    SubmissionDate,
    ReportStatus,
    CourtName
FROM CourtReport
WHERE ReportStatus = 'Pending';


CREATE VIEW InvestigationSummary AS
SELECT
    i.InvestigationID,
    fc.CaseID,
    fc.CaseType,
    d.DoctorName,
    i.InvestigationType,
    i.RequestedDate,
    i.Finding,
    i.ResultDate,
    i.Status
FROM Investigation i
JOIN ForensicCase fc
ON i.CaseID = fc.CaseID
JOIN Doctor d
ON i.DoctorID = d.DoctorID;


CREATE VIEW DocumentManagement AS
SELECT
    d.DocumentID,
    fc.CaseID,
    fc.CaseType,
    d.DocumentType,
    d.FilePath,
    d.UploadDate,
    s.StaffName,
    d.Description
FROM Document d
JOIN ForensicCase fc
ON d.CaseID = fc.CaseID
JOIN Staff s
ON d.StaffID = s.StaffID;


CREATE VIEW LaboratoryTestSummary AS
SELECT
    lt.TestID,
    lt.TestType,
    lt.RequestedDate,
    lt.Result,
    lt.ResultDate,
    lt.TestStatus,
    e.EvidenceID,
    e.EvidenceType,
    fc.CaseID,
    fc.CaseType
FROM LaboratoryTest lt
JOIN Evidence e
ON lt.EvidenceID = e.EvidenceID
JOIN ForensicCase fc
ON lt.CaseID = fc.CaseID;