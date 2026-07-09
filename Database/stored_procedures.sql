use forensic_medical_db;

Delimiter //

create procedure AddPatient(
    IN p_FullName varchar(100),
    IN p_NIC VARCHAR(12),
    IN p_DOB DATE,
    IN p_Gender VARCHAR(10),
    IN p_Address VARCHAR(255),
    IN p_ContactNo VARCHAR(15)

)
begin 
	insert into patient (Fullname,NIC,DOB,Gender,Address,ContactNo)
	values  (p_FullName, p_NIC, p_DOB, p_Gender, p_Address, p_ContactNo);

end //

delimiter ;
CALL AddPatient(
    'Nimal Perera',
    '200032345678',
    '2000-05-12',
    'Male',
    'Kandy',
    '0712345678'
);

select * from Patient;
Delete from  Patient where NIC=200032345678;

select * from Patient;





delimiter //
create procedure RegisterForensicCase(
    IN p_PatientID INT,
    IN p_IncidentDate DATE,
    IN p_Status VARCHAR(20),
    IN p_Description TEXT,
    IN p_CaseType VARCHAR(50)

)

begin
	insert into ForensicCase (PatientID, IncidentDate, Status, Description, CaseType)
	values(p_PatientID, p_IncidentDate, p_Status, p_Description, p_CaseType);

end //

delimiter ;

CALL RegisterForensicCase(
    1,
    '2026-07-08',
    'Open',
    'Road traffic accident case',
    'Trauma Patient'
);
select * from ForensicCase;


delimiter //
create procedure AddEvidence (
    IN p_CaseID INT,
    IN p_EvidenceType VARCHAR(50),
    IN p_Description TEXT,
    IN p_CollectedDate DATE,
    IN p_StorageLocation VARCHAR(100),
    IN p_CurrentStatus VARCHAR(30)

)
begin 
	insert into Evidence(CaseID,EvidenceType,
        Description,
        CollectedDate,
        StorageLocation,
        CurrentStatus)
     values (p_CaseID,
        p_EvidenceType,
        p_Description,
        p_CollectedDate,
        p_StorageLocation,
        p_CurrentStatus);
end //

delimiter ;

CALL AddEvidence(
    1,
    'Blood',
    'Blood sample collected from patient',
    '2026-07-08',
    'Evidence Locker A',
    'Collected'
);
select * from Evidence;


delimiter //

create procedure UpdateReportStatus(
 IN p_ReportID INT,
 IN p_NewStatus VARCHAR(20)

)
begin 
	update CourtReport
	set ReportStatus=p_NewStatus
	where ReportID=p_ReportID;

end  //
delimiter ;



CALL AddPatient(
    'Kamal Silva',
    '199812345679',
    '1998-11-20',
    'Male',
    'Colombo',
    '0779876543'
);

CALL AddPatient(
    'Sanduni Fernando',
    '200112345670',
    '2001-03-15',
    'Female',
    'Galle',
    '0761234567'
);
INSERT INTO Doctor (DoctorName, Specialization, Qualification, LicenseNo, ContactNo, Email, AvailabilityStatus)
VALUES
('Dr. A. Perera','Forensic Medicine','MBBS, MD','LIC1001','0711111111','aperera@hospital.lk','Available'),
('Dr. B. Silva','Forensic Pathology','MBBS, MD','LIC1002','0722222222','bsilva@hospital.lk','Busy');

INSERT INTO Staff (StaffName, Role, Department, ContactNo, Email, EmploymentDate, Status)
VALUES
('Saman Kumara','Clerk','Administration','0751111111','saman@hospital.lk','2023-01-10','Active'),
('Nadeesha Perera','Lab Technician','Laboratory','0752222222','nadeesha@hospital.lk','2022-06-20','Active');
CALL RegisterForensicCase(
    4,
    '2026-07-06',
    'Pending',
    'Domestic violence investigation',
    'Domestic Abuse'
);

CALL RegisterForensicCase(
    5,
    '2026-07-07',
    'Open',
    'Postmortem examination',
    'Postmortem'
);
select * from Patient;


CALL AddEvidence(1, 'Blood', 'Blood sample collected', '2026-07-05', 'Locker A', 'Collected');
CALL AddEvidence(1, 'Knife', 'Knife recovered from scene', '2026-07-05', 'Locker B', 'Stored');
CALL AddEvidence(4, 'Clothing', 'Victim clothing', '2026-07-06', 'Locker C', 'In Lab');
select * from ForensicCase;






insert into CourtReport (CaseID, DoctorID, ReportType, SubmissionDate, ReportStatus, CourtName)
VALUES (1,1,'MLR','2026-07-08','Pending','Kandy Magistrate Court');

select * from CourtReport;
CALL UpdateReportStatus(1, 'Submitted');
select * from CourtReport;





select * from Evidence where EvidenceID=1;

delimiter //

create procedure UpdateEvidenceStatus(
    IN p_EvidenceID INT,
    IN p_NewStatus VARCHAR(30)

)
begin 
	update Evidence
	set CurrentStatus=p_NewStatus
	where EvidenceID=p_EvidenceID;

end //


delimiter ;

call UpdateEvidenceStatus(1,'In Lab');
select * from Evidence where EvidenceID=1;

