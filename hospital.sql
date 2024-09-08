-- Drop the hospital_management database if it exists
DROP DATABASE IF EXISTS hospital_management;

-- Create the hospital_management database
CREATE DATABASE IF NOT EXISTS hospital_management;
USE hospital_management;

-- Drop the online_retail_app database if it exists
DROP DATABASE IF EXISTS online_retail_app;

-- Create the online_retail_app database
CREATE DATABASE IF NOT EXISTS online_retail_app;
USE online_retail_app;

-- Create user_login table in online_retail_app schema
DROP TABLE IF EXISTS user_login;
CREATE TABLE IF NOT EXISTS user_login (
    user_id VARCHAR(50) PRIMARY KEY,          -- Specified length for VARCHAR
    user_password VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    sign_up_on DATE,
    email_id VARCHAR(100)
);

-- Switch to the hospital_management database
USE hospital_management;

-- Create patient table
DROP TABLE IF EXISTS patient;
CREATE TABLE IF NOT EXISTS patient (
    email VARCHAR(50) PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(60) NOT NULL,
    gender VARCHAR(20) NOT NULL
);

-- Create appointment table
DROP TABLE IF EXISTS appointment;
CREATE TABLE IF NOT EXISTS appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status VARCHAR(15) NOT NULL
);

-- Create medical_history table
DROP TABLE IF EXISTS medical_history;
CREATE TABLE IF NOT EXISTS medical_history (
    medical_history_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    conditions VARCHAR(100) NOT NULL,
    surgeries VARCHAR(100) NOT NULL,
    medication VARCHAR(100) NOT NULL
);

-- Create doctor table
DROP TABLE IF EXISTS doctor;
CREATE TABLE IF NOT EXISTS doctor (
    email VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(20) NOT NULL,
    password VARCHAR(30) NOT NULL,
    name VARCHAR(50) NOT NULL
);

-- Create patient_visits table
DROP TABLE IF EXISTS patient_visits;
CREATE TABLE IF NOT EXISTS patient_visits (
    patient VARCHAR(50) NOT NULL,
    appt INT NOT NULL,
    concerns VARCHAR(40) NOT NULL,
    symptoms VARCHAR(40) NOT NULL,
    FOREIGN KEY (patient) REFERENCES patient (email) ON DELETE CASCADE,
    FOREIGN KEY (appt) REFERENCES appointment (appointment_id) ON DELETE CASCADE,
    PRIMARY KEY (patient, appt)
);

-- Create schedule table
DROP TABLE IF EXISTS schedule;
CREATE TABLE IF NOT EXISTS schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    break_time TIME NOT NULL,
    day VARCHAR(20) NOT NULL
);

-- Create patients_history table
DROP TABLE IF EXISTS patients_history;
CREATE TABLE IF NOT EXISTS patients_history (
    patient VARCHAR(50) NOT NULL,
    history INT NOT NULL,
    FOREIGN KEY (patient) REFERENCES patient (email) ON DELETE CASCADE,
    FOREIGN KEY (history) REFERENCES medical_history (medical_history_id) ON DELETE CASCADE,
    PRIMARY KEY (history)
);

-- Create diagnose table
DROP TABLE IF EXISTS diagnose;
CREATE TABLE IF NOT EXISTS diagnose (
    appt INT NOT NULL,
    doctor VARCHAR(50) NOT NULL,
    diagnosis VARCHAR(40) NOT NULL,
    prescription VARCHAR(50) NOT NULL,
    FOREIGN KEY (appt) REFERENCES appointment (appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor) REFERENCES doctor (email) ON DELETE CASCADE,
    PRIMARY KEY (appt, doctor)
);

-- Create doctor_schedules table
DROP TABLE IF EXISTS doctor_schedules;
CREATE TABLE IF NOT EXISTS doctor_schedules (
    sched INT NOT NULL,
    doctor VARCHAR(50) NOT NULL,
    FOREIGN KEY (sched) REFERENCES schedule (schedule_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor) REFERENCES doctor (email) ON DELETE CASCADE,
    PRIMARY KEY (sched, doctor)
);

-- Create doctor_view_history table
DROP TABLE IF EXISTS doctor_view_history;
CREATE TABLE IF NOT EXISTS doctor_view_history (
    history INT NOT NULL,
    doctor VARCHAR(50) NOT NULL,
    FOREIGN KEY (doctor) REFERENCES doctor (email) ON DELETE CASCADE,
    FOREIGN KEY (history) REFERENCES medical_history (medical_history_id) ON DELETE CASCADE,
    PRIMARY KEY (history, doctor)
);
