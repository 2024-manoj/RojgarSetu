DROP DATABASE IF EXISTS rojgarsetu;
CREATE DATABASE rojgarsetu;
USE rojgarsetu;
CREATE TABLE users (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) UNIQUE NOT NULL,
                       phone VARCHAR(20),
                       password VARCHAR(255) NOT NULL,
                       role ENUM('ADMIN', 'SEEKER', 'EMPLOYER') DEFAULT 'SEEKER',
                       status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
                       location VARCHAR(100),
                       dob DATE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE seeker_profile (
                                id INT PRIMARY KEY AUTO_INCREMENT,
                                user_id INT NOT NULL,
                                address_city VARCHAR(100),
                                skills TEXT,
                                education VARCHAR(255),
                                experience_year INT DEFAULT 0,
                                resume_path VARCHAR(500),
                                FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TABLE employer_profile (
                                  id INT PRIMARY KEY AUTO_INCREMENT,
                                  user_id INT NOT NULL,
                                  company_name VARCHAR(150) NOT NULL,
                                  company_address TEXT,
                                  company_category VARCHAR(100),
                                  company_city VARCHAR(50),
                                  company_description TEXT,
                                  contact_person VARCHAR(100),
                                  verified_at TIMESTAMP NULL,
                                  verified_by INT,
                                  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TABLE jobs (
                      job_id INT PRIMARY KEY AUTO_INCREMENT,
                      employer_id INT NOT NULL,
                      title VARCHAR(150) NOT NULL,
                      description TEXT,
                      category VARCHAR(100),
                      location_city VARCHAR(100),
                      salary_range VARCHAR(100),
                      job_type ENUM('Full-time', 'Part-time', 'Contract', 'Internship') DEFAULT 'Full-time',
                      posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      deadline DATE,
                      status ENUM('pending', 'approved', 'rejected', 'expired') DEFAULT 'pending',
                      approved_at TIMESTAMP NULL,
                      approved_by INT,
                      FOREIGN KEY (employer_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TABLE applications (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              job_id INT NOT NULL,
                              seeker_id INT NOT NULL,
                              cover_letter TEXT,
                              status ENUM('pending', 'shortlisted', 'rejected', 'hired') DEFAULT 'pending',
                              applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              reviewed_at TIMESTAMP NULL,
                              FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
                              FOREIGN KEY (seeker_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TABLE saved_jobs (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            seeker_id INT NOT NULL,
                            job_id INT NOT NULL,
                            saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (seeker_id) REFERENCES users(id) ON DELETE CASCADE,
                            FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
                            UNIQUE KEY unique_saved (seeker_id, job_id)
);
SHOW TABLES;
INSERT INTO users (full_name, email, password, role, status)
VALUES ('Admin User', 'admin@rojgarsetu.com', '$2a$10$erk0I2eXzVVUelCXBTUcIu4c/gZ7IhT2nVIWJmXMAh02ly.SNW9kC', 'ADMIN', 'APPROVED');
