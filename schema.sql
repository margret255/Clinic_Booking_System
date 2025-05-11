
--  Patients table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL
);

-- Doctors table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    DateJoined DATE NOT NULL
);

-- Appointments table (1-M relation between Patients and Doctors)
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason VARCHAR(255),
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE
);

--  Specializations table (holds all possible specializations)
CREATE TABLE Specializations (
    SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
    SpecializationName VARCHAR(100) UNIQUE NOT NULL
);

-- DoctorSpecializations table (M-M relation between Doctors and Specializations)
CREATE TABLE DoctorSpecializations (
    DoctorID INT NOT NULL,
    SpecializationID INT NOT NULL,
    PRIMARY KEY (DoctorID, SpecializationID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE,
    FOREIGN KEY (SpecializationID) REFERENCES Specializations(SpecializationID) ON DELETE CASCADE
);

-- Sample data for Patients table
INSERT INTO Patients (FirstName, LastName, Email, Phone, DateOfBirth, Gender)
VALUES
    ('John', 'Doe', 'johndoe@example.com', '1234567890', '1990-01-01', 'Male'),
    ('Jane', 'Smith', 'janesmith@example.com', '0987654321', '1985-06-15', 'Female');

-- Sample data for the Doctors table
INSERT INTO Doctors (FirstName, LastName, Email, Phone, Specialization, DateJoined)
VALUES
    ('Dr. Alice', 'Johnson', 'alice.johnson@example.com', '1112223333', 'Cardiologist', '2020-03-01'),
    ('Dr. Bob', 'Miller', 'bob.miller@example.com', '4445556666', 'Dermatologist', '2021-06-15');

-- Sample data for the Specializations table
INSERT INTO Specializations (SpecializationName)
VALUES
    ('Cardiology'),
    ('Dermatology'),
    ('Orthopedics');

-- Sample data for the DoctorSpecializations table
INSERT INTO DoctorSpecializations (DoctorID, SpecializationID)
VALUES
    (1, 1),  -- Dr. Alice Johnson specializes in Cardiology
    (2, 2);  -- Dr. Bob Miller specializes in Dermatology

-- Sample data for the Appointments table
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason, Status)
VALUES
    (1, 1, '2025-05-01 10:00:00', 'Heart checkup', 'Scheduled'),
    (2, 2, '2025-05-02 14:00:00', 'Skin rash consultation', 'Scheduled');
