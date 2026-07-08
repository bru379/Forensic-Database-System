
use forensic_medical_db;



CREATE INDEX idx_patient_nic
ON Patient(NIC);

CREATE INDEX idx_case_type
ON ForensicCase(CaseType);
CREATE INDEX idx_evidence_type
ON Evidence(EvidenceType);

CREATE INDEX idx_test_type
ON LaboratoryTest(TestType);

CREATE INDEX idx_report_status
ON CourtReport(ReportStatus);

CREATE INDEX idx_investigation_type
ON Investigation(InvestigationType);

CREATE INDEX idx_document_type
ON Document(DocumentType);

CREATE INDEX idx_action_time
ON AuditLog(ActionTime);