-- Creating Database
CREATE DATABASE Clinic_Booking_System;

-- Using the Database
USE Clinic_Booking_System;

-- Departments
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Users (for login)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Roles (e.g., Admin, Nurse, Doctor)
CREATE TABLE Roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- UserRoles (M-M)
CREATE TABLE UserRoles (
    user_id INT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Doctors
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    specialization VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Nurses
CREATE TABLE Nurses (
    nurse_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Patients
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other')
);

-- Appointments
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Medications
CREATE TABLE Medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Prescriptions
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100),
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id),
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);

-- Lab Tests
CREATE TABLE LabTests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    test_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Test Results
CREATE TABLE TestResults (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    test_id INT NOT NULL,
    appointment_id INT,
    result_date DATE,
    result_value TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (test_id) REFERENCES LabTests(test_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Rooms
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    type ENUM('Consultation', 'Surgery', 'Ward', 'ICU'),
    capacity INT
);

-- Admissions
CREATE TABLE Admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    room_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Invoices
CREATE TABLE Invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    invoice_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    status ENUM('Pending', 'Paid') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Payments
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    amount_paid DECIMAL(10,2),
    payment_date DATE,
    method ENUM('Cash', 'Card', 'Insurance'),
    FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id)
);

-- Insert Departments
INSERT INTO Departments (department_name) VALUES ('Cardiology');
INSERT INTO Departments (department_name) VALUES ('Pediatrics');
INSERT INTO Departments (department_name) VALUES ('Neurology');
INSERT INTO Departments (department_name) VALUES ('Orthopedics');
INSERT INTO Departments (department_name) VALUES ('General Medicine');

-- Insert Roles
INSERT INTO Roles (role_name) VALUES ('Admin');
INSERT INTO Roles (role_name) VALUES ('Doctor');
INSERT INTO Roles (role_name) VALUES ('Nurse');
INSERT INTO Roles (role_name) VALUES ('Receptionist');
INSERT INTO Roles (role_name) VALUES ('Pharmacist');

-- Insert Users
INSERT INTO Users (username, password_hash, email) VALUES ('user1', 'hash1', 'user1@clinic.com');
INSERT INTO Users (username, password_hash, email) VALUES ('user2', 'hash2', 'user2@clinic.com');
INSERT INTO Users (username, password_hash, email) VALUES ('user3', 'hash3', 'user3@clinic.com');
INSERT INTO Users (username, password_hash, email) VALUES ('user4', 'hash4', 'user4@clinic.com');
INSERT INTO Users (username, password_hash, email) VALUES ('user5', 'hash5', 'user5@clinic.com');

-- Insert UserRoles
INSERT INTO UserRoles (user_id, role_id) VALUES (1, 1);
INSERT INTO UserRoles (user_id, role_id) VALUES (2, 2);
INSERT INTO UserRoles (user_id, role_id) VALUES (3, 3);
INSERT INTO UserRoles (user_id, role_id) VALUES (4, 4);
INSERT INTO UserRoles (user_id, role_id) VALUES (5, 5);

-- Insert Doctors
INSERT INTO Doctors (full_name, email, phone, specialization, department_id)
VALUES ('Erin Jacobs', 'porterjohn@hotmail.com', '001-386-62', 'Specialist 1', 4);
INSERT INTO Doctors (full_name, email, phone, specialization, department_id)
VALUES ('Sherry Knight', 'curtisabigail@hotmail.com', '001-665-47', 'Specialist 2', 3);
INSERT INTO Doctors (full_name, email, phone, specialization, department_id)
VALUES ('Christopher Carson', 'lmartinez@gmail.com', '163-889-34', 'Specialist 3', 1);
INSERT INTO Doctors (full_name, email, phone, specialization, department_id)
VALUES ('John Thomas', 'gsloan@gmail.com', '352-367-38', 'Specialist 4', 4);
INSERT INTO Doctors (full_name, email, phone, specialization, department_id)
VALUES ('Kimberly Sanchez', 'scott63@gmail.com', '+1-076-267', 'Specialist 5', 2);

-- Insert Nurses
INSERT INTO Nurses (full_name, email, phone, department_id)
VALUES ('Stephen Aguilar', 'karen21@mendoza.net', '148.796.49', 5);
INSERT INTO Nurses (full_name, email, phone, department_id)
VALUES ('Melanie Mason', 'anthonyreynolds@garner.com', '897-268-12', 1);
INSERT INTO Nurses (full_name, email, phone, department_id)
VALUES ('Steven Gilbert', 'lisa17@yahoo.com', '453.467.59', 1);
INSERT INTO Nurses (full_name, email, phone, department_id)
VALUES ('William Barber', 'perry24@travis.com', '562.154.98', 4);
INSERT INTO Nurses (full_name, email, phone, department_id)
VALUES ('Jeremy Hughes', 'johnward@hotmail.com', '239-050-41', 1);

-- Insert Patients
INSERT INTO Patients (full_name, email, phone, date_of_birth, gender)
VALUES ('Tonya Jones', 'mason77@morgan-ford.net', '001-822-30', '1981-05-09', 'Male');
INSERT INTO Patients (full_name, email, phone, date_of_birth, gender)
VALUES ('Jerry Wyatt', 'williamsfrancisco@buckley-scott.net', '+1-346-945', '1990-09-22', 'Male');
INSERT INTO Patients (full_name, email, phone, date_of_birth, gender)
VALUES ('Amanda Ford', 'zsandoval@hotmail.com', '(706)167-6', '2001-04-17', 'Male');
INSERT INTO Patients (full_name, email, phone, date_of_birth, gender)
VALUES ('Brandon Shepherd', 'matthew27@hotmail.com', '001-216-74', '1988-12-24', 'Male');
INSERT INTO Patients (full_name, email, phone, date_of_birth, gender)
VALUES ('Jill Clark', 'chasesingleton@velez.com', '035.014.75', '2002-04-14', 'Female');

-- Insert Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES (3, 1, '2025-04-26', '18:19:22', 'Scheduled', 'Checkup');
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES (1, 4, '2025-01-23', '04:40:00', 'Scheduled', 'Checkup');
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES (2, 3, '2025-03-08', '15:53:50', 'Scheduled', 'Checkup');
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES (2, 4, '2025-04-04', '03:40:38', 'Scheduled', 'Checkup');
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES (2, 1, '2025-03-11', '20:09:32', 'Scheduled', 'Checkup');

-- Insert Medications
INSERT INTO Medications (name, description) VALUES ('Paracetamol', 'Used for treatment.');
INSERT INTO Medications (name, description) VALUES ('Amoxicillin', 'Used for treatment.');
INSERT INTO Medications (name, description) VALUES ('Ibuprofen', 'Used for treatment.');
INSERT INTO Medications (name, description) VALUES ('Metformin', 'Used for treatment.');
INSERT INTO Medications (name, description) VALUES ('Ciprofloxacin', 'Used for treatment.');

-- Insert Prescriptions
INSERT INTO Prescriptions (appointment_id, medication_id, dosage, instructions)
VALUES (1, 5, '1 tablet twice daily', 'Take after meals');
INSERT INTO Prescriptions (appointment_id, medication_id, dosage, instructions)
VALUES (3, 4, '1 tablet twice daily', 'Take after meals');
INSERT INTO Prescriptions (appointment_id, medication_id, dosage, instructions)
VALUES (4, 3, '1 tablet twice daily', 'Take after meals');
INSERT INTO Prescriptions (appointment_id, medication_id, dosage, instructions)
VALUES (2, 1, '1 tablet twice daily', 'Take after meals');
INSERT INTO Prescriptions (appointment_id, medication_id, dosage, instructions)
VALUES (2, 5, '1 tablet twice daily', 'Take after meals');

-- Insert LabTests
INSERT INTO LabTests (test_name, description) VALUES ('CBC', 'Standard medical test');
INSERT INTO LabTests (test_name, description) VALUES ('Blood Sugar', 'Standard medical test');
INSERT INTO LabTests (test_name, description) VALUES ('X-Ray', 'Standard medical test');
INSERT INTO LabTests (test_name, description) VALUES ('MRI', 'Standard medical test');
INSERT INTO LabTests (test_name, description) VALUES ('ECG', 'Standard medical test');

-- Insert TestResults
INSERT INTO TestResults (patient_id, test_id, appointment_id, result_date, result_value)
VALUES (5, 1, 1, '2025-02-19', 'Normal');
INSERT INTO TestResults (patient_id, test_id, appointment_id, result_date, result_value)
VALUES (4, 2, 4, '2025-05-09', 'Normal');
INSERT INTO TestResults (patient_id, test_id, appointment_id, result_date, result_value)
VALUES (1, 3, 3, '2025-01-31', 'Normal');
INSERT INTO TestResults (patient_id, test_id, appointment_id, result_date, result_value)
VALUES (1, 5, 4, '2025-02-22', 'Normal');
INSERT INTO TestResults (patient_id, test_id, appointment_id, result_date, result_value)
VALUES (3, 5, 2, '2025-01-11', 'Normal');

-- Insert Rooms
INSERT INTO Rooms (room_number, type, capacity)
VALUES ('100', 'Ward', 3);
INSERT INTO Rooms (room_number, type, capacity)
VALUES ('101', 'Surgery', 4);
INSERT INTO Rooms (room_number, type, capacity)
VALUES ('102', 'Consultation', 4);
INSERT INTO Rooms (room_number, type, capacity)
VALUES ('103', 'ICU', 3);
INSERT INTO Rooms (room_number, type, capacity)
VALUES ('104', 'Consultation', 2);

-- Insert Admissions
INSERT INTO Admissions (patient_id, room_id, admission_date, discharge_date, reason)
VALUES (3, 5, '2025-04-13', NULL, 'General observation');
INSERT INTO Admissions (patient_id, room_id, admission_date, discharge_date, reason)
VALUES (2, 1, '2025-02-22', NULL, 'General observation');
INSERT INTO Admissions (patient_id, room_id, admission_date, discharge_date, reason)
VALUES (2, 5, '2025-01-08', NULL, 'General observation');
INSERT INTO Admissions (patient_id, room_id, admission_date, discharge_date, reason)
VALUES (4, 3, '2025-03-21', NULL, 'General observation');
INSERT INTO Admissions (patient_id, room_id, admission_date, discharge_date, reason)
VALUES (3, 5, '2025-04-07', NULL, 'General observation');

-- Insert Invoices
INSERT INTO Invoices (patient_id, invoice_date, total_amount, status)
VALUES (5, '2025-03-14', 4345, 'Pending');
INSERT INTO Invoices (patient_id, invoice_date, total_amount, status)
VALUES (3, '2025-04-17', 3012, 'Pending');
INSERT INTO Invoices (patient_id, invoice_date, total_amount, status)
VALUES (3, '2025-03-03', 3822, 'Pending');
INSERT INTO Invoices (patient_id, invoice_date, total_amount, status)
VALUES (5, '2025-03-27', 4440, 'Pending');
INSERT INTO Invoices (patient_id, invoice_date, total_amount, status)
VALUES (4, '2025-03-01', 4169, 'Pending');

-- Insert Payments
INSERT INTO Payments (invoice_id, amount_paid, payment_date, method)
VALUES (5, 3481, '2025-01-27', 'Cash');
INSERT INTO Payments (invoice_id, amount_paid, payment_date, method)
VALUES (2, 845, '2025-03-14', 'Card');
INSERT INTO Payments (invoice_id, amount_paid, payment_date, method)
VALUES (1, 2337, '2025-05-05', 'Insurance');
INSERT INTO Payments (invoice_id, amount_paid, payment_date, method)
VALUES (1, 4340, '2025-04-13', 'Insurance');
INSERT INTO Payments (invoice_id, amount_paid, payment_date, method)
VALUES (4, 1769, '2025-04-06', 'Cash');

-- Check the data in all tables
SELECT * FROM Departments;
SELECT * FROM Users;
SELECT * FROM Roles;
SELECT * FROM UserRoles;
SELECT * FROM Doctors;                                  
SELECT * FROM Nurses;
SELECT * FROM Patients;
SELECT * FROM Appointments;
SELECT * FROM Medications;
SELECT * FROM Prescriptions;
SELECT * FROM LabTests;
SELECT * FROM TestResults;
SELECT * FROM Rooms;
SELECT * FROM Admissions;
SELECT * FROM Invoices;
SELECT * FROM Payments;
