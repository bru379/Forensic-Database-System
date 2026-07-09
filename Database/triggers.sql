use forensic_medical_db;
select * from Patient;
call AddPatient('Dinushan','200712345678','2000-11-12','Male',
    'Kandy',
    '0712345678');
call AddPatient('Nilaxsan','200212345678','2002-11-12','Male',
    'VADA',
    '0712395678');

call AddPatient('srikaran','200719345678','2006-11-12','Male',
    'Jaffna',
    '0712345698');
select * from Patient;

select * from Doctor;

INSERT INTO Doctor
(
DoctorName,
Specialization,
Qualification,
LicenseNo,
ContactNo,
Email,
AvailabilityStatus
)
VALUES
(
'Dr.K.Anjala Bandara',
'Forensic Medicine',
'MBBS, MD',
'LIC1003',
'0711111611',
'aandaraera@hospital.lk',
'Available'
),
(
'Dr. B. ROSHAEN',
'Forensic Pathology',
'MBBS, MD',
'LIC1004',
'0722224222',
'bshuanva@hospital.lk',
'Busy'
);
select * from Doctor;

select * from Staff;
INSERT INTO Staff
(
StaffName,
Role,
Department,
ContactNo,
Email,
EmploymentDate,
Status
)
VALUES
(
'Kabilan K',
'Clerk',
'Administration',
'07511891111',
'Kabilan@hospital.lk',
'2013-01-10',
'Active'
),
(
'Nahid Rana',
'Lab Technician',
'Laboratory',
'075227722',
'nadeensha@hospital.lk',
'2020-06-20',
'Active'
);

select * from Staff;

select * from  ForensicCase;

SELECT * FROM AuditLog;
INSERT INTO UserAccount
(
    Username,
    PasswordHash,
    UserRole,
    DoctorID,
    StaffID,
    AccountStatus
)
VALUES
(
    'doctor1',
    'hashed_password',
    'Doctor',
    1,
    NULL,
    'Active'
),
(
    'staff1',
    'hashed_password',
    'Staff',
    NULL,
    1,
    'Active'
);
CALL RegisterForensicCase(1
,
'2026-07-07',
'Open',
'Postmortem examination',
'Postmortem'
);


INSERT INTO LaboratoryTest
(CaseID, EvidenceID, TestType, RequestedDate, Result, ResultDate, TestStatus)
VALUES
(1, 1, 'DNA', '2026-07-06', 'DNA matched', '2026-07-07', 'Completed');

INSERT INTO CourtReport
(CaseID, DoctorID, ReportType, SubmissionDate, ReportStatus, CourtName)
VALUES
(1, 1, 'MLR', '2026-07-08', 'Pending', 'Kandy Magistrate Court');

INSERT INTO Postmortem
(CaseID, DoctorID, PMNumber, AutopsyDate, Findings, CauseOfDeath, MannerOfDeath, PMStatus)
VALUES
(1, 2, 'PM2026001', '2026-07-08', 'Multiple internal injuries', 'Head injury', 'Accidental', 'Completed');

INSERT INTO MLEF
(MLEFNumber, CaseID, IssueDate, DoctorID, PoliceStation, Status)
VALUES
('MLEF1001', 1, '2026-07-06', 1, 'Kandy Police', 'Issued');

INSERT INTO Investigation
(CaseID, DoctorID, InvestigationType, RequestedDate, Finding, ResultDate, Status)
VALUES
(1, 1, 'CT Scan', '2026-07-06', 'Head injury observed', '2026-07-06', 'Completed');

INSERT INTO Referral
(CaseID, DoctorID, ReferredTo, ReferralDate, Reason, ReferralStatus)
VALUES
(1, 2, 'Psychiatry', '2026-07-07', 'Psychological assessment required', 'Pending');

INSERT INTO CourtRequest
(CaseID, CourtName, RequestDate, RequestType, DueDate, Status)
VALUES
(1, 'Kandy Magistrate Court', '2026-07-07', 'Court Order', '2026-07-20', 'Pending');

INSERT INTO Document
(CaseID, DocumentType, FilePath, StaffID, UploadDate, Description)
VALUES
(1, 'MLR Copy', '/documents/mlr001.pdf', 1, '2026-07-08', 'Initial medical report');

INSERT INTO ChainOfCustody
(EvidenceID, FromPerson, ToPerson, TransferDate, Purpose, Remarks)
VALUES
(1, 'Police Officer', 'Laboratory Technician', '2026-07-06', 'DNA Analysis', 'Transferred safely');

CALL RegisterForensicCase(
    1,
    '2026-07-10',
    'Open',
    'Road traffic accident involving a motorcycle and a car.',
    'Trauma Patient'
);
CALL RegisterForensicCase(
    4,
    '2026-07-11',
    'Pending',
    'Patient reported physical assault by a family member.',
    'Domestic Abuse'
);
CALL RegisterForensicCase(
    7,
    '2026-07-12',
    'Open',
    'Medical examination requested for a detainee before court appearance.',
    'Detainee'
);

CALL RegisterForensicCase(
    8,
    '2026-07-13',
    'Closed',
    'Age estimation requested for legal identification purposes.',
    'Age Estimation'
);
CALL RegisterForensicCase(
    8,
    '2026-07-14',
    'Open',
    'Postmortem examination requested after a suspicious death.',
    'Postmortem'
);

INSERT INTO Staff
(
    StaffName,
    Role,
    Department,
    ContactNo,
    Email,
    EmploymentDate,
    Status
)
VALUES
(
    'K HOPE',
    'Evidence Custodian',
    'Evidence Management',
    '0753333333',
    'kahOPE.j@forensic.lk',
    '2023-03-10',
    'Active'
),
(
    'EDWARDS CA',
    'Medical Records Officer',
    'Medical Records',
    '0754444444',
    'edwardsCA.f@forensic.lk',
    '2020-11-05',
    'Active'
),
(
    'Jacob Bethell',
    'Reception Officer',
    'Reception',
    '0755555555',
    'bethell@forensic.lk',
    '2024-02-01',
    'Active'
);

select * from Staff;
INSERT INTO UserAccount
(
    Username,
    PasswordHash,
    UserRole,
    DoctorID,
    StaffID,
    AccountStatus
)
VALUES
('aperera', 'hashed_password_1', 'Doctor', 4, NULL, 'Active'),
('bsilva', 'hashed_password_2', 'Doctor', 2, NULL, 'Active'),
('saman', 'hashed_password_3', 'Staff', NULL, 5, 'Active'),
('nadeesha', 'hashed_password_4', 'Staff', NULL, 2, 'Active'),
('edwardsca', 'hashed_password_5', 'Staff', NULL, 6, 'Active');
