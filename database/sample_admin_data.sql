USE rojgarsetu;

-- Demo users for admin pages (password hashes are placeholder bcrypt values).
INSERT INTO users (full_name, email, phone, password, role, status, location, dob)
VALUES
('Admin User', 'admin@rojgarsetu.com', '9800000000', '$2a$10$erk0I2eXzVVUelCXBTUcIu4c/gZ7IhT2nVIWJmXMAh02ly.SNW9kC', 'ADMIN', 'APPROVED', 'Itahari', '1995-01-01'),
('Sunita Karki', 'sunita@biznepal.com', '9811111111', '$2a$10$erk0I2eXzVVUelCXBTUcIu4c/gZ7IhT2nVIWJmXMAh02ly.SNW9kC', 'EMPLOYER', 'APPROVED', 'Dharan', '1992-08-11'),
('Ramesh Rai', 'ramesh@rojgar.com', '9822222222', '$2a$10$erk0I2eXzVVUelCXBTUcIu4c/gZ7IhT2nVIWJmXMAh02ly.SNW9kC', 'SEEKER', 'PENDING', 'Biratnagar', '2000-04-10'),
('Anita Limbu', 'anita@hirehub.com', '9833333333', '$2a$10$erk0I2eXzVVUelCXBTUcIu4c/gZ7IhT2nVIWJmXMAh02ly.SNW9kC', 'EMPLOYER', 'PENDING', 'Itahari', '1998-03-03'),
('Bikash Shrestha', 'bikash@jobmail.com', '9844444444', '$2a$10$erk0I2eXzVVUelCXBTUcIu4c/gZ7IhT2nVIWJmXMAh02ly.SNW9kC', 'SEEKER', 'APPROVED', 'Damak', '1999-10-22')
ON DUPLICATE KEY UPDATE
full_name = VALUES(full_name),
phone = VALUES(phone),
role = VALUES(role),
status = VALUES(status),
location = VALUES(location),
dob = VALUES(dob);

-- Employer profiles
INSERT INTO employer_profile (user_id, company_name, company_address, company_category, company_city, company_description, contact_person)
SELECT id, 'Biz Nepal Pvt. Ltd.', 'Main Road, Dharan', 'IT Services', 'Dharan', 'Software and support services', 'Sunita Karki'
FROM users WHERE email = 'sunita@biznepal.com'
ON DUPLICATE KEY UPDATE
company_name = VALUES(company_name),
company_address = VALUES(company_address),
company_category = VALUES(company_category),
company_city = VALUES(company_city),
company_description = VALUES(company_description),
contact_person = VALUES(contact_person);

INSERT INTO employer_profile (user_id, company_name, company_address, company_category, company_city, company_description, contact_person)
SELECT id, 'HireHub Trading', 'Bus Park Line, Itahari', 'Retail', 'Itahari', 'Retail and store operations', 'Anita Limbu'
FROM users WHERE email = 'anita@hirehub.com'
ON DUPLICATE KEY UPDATE
company_name = VALUES(company_name),
company_address = VALUES(company_address),
company_category = VALUES(company_category),
company_city = VALUES(company_city),
company_description = VALUES(company_description),
contact_person = VALUES(contact_person);

-- Seeker profiles
INSERT INTO seeker_profile (user_id, address_city, skills, education, experience_year, resume_path)
SELECT id, 'Biratnagar', 'Java, Spring Boot, SQL', 'BSc CSIT', 1, NULL
FROM users WHERE email = 'ramesh@rojgar.com'
ON DUPLICATE KEY UPDATE
address_city = VALUES(address_city),
skills = VALUES(skills),
education = VALUES(education),
experience_year = VALUES(experience_year),
resume_path = VALUES(resume_path);

INSERT INTO seeker_profile (user_id, address_city, skills, education, experience_year, resume_path)
SELECT id, 'Damak', 'Accounting, Excel, Communication', '+2 Management', 2, NULL
FROM users WHERE email = 'bikash@jobmail.com'
ON DUPLICATE KEY UPDATE
address_city = VALUES(address_city),
skills = VALUES(skills),
education = VALUES(education),
experience_year = VALUES(experience_year),
resume_path = VALUES(resume_path);

-- Jobs (mix of approved/pending/rejected so admin dashboard and reports are populated)
INSERT INTO jobs (employer_id, title, description, category, location_city, salary_range, job_type, deadline, status, approved_at, approved_by)
SELECT u.id, 'Junior Java Developer', 'Build and maintain backend modules', 'IT', 'Dharan', 'NPR 35,000 - 55,000', 'Full-time', DATE_ADD(CURDATE(), INTERVAL 30 DAY), 'approved', NOW(), (SELECT id FROM users WHERE email = 'admin@rojgarsetu.com')
FROM users u WHERE u.email = 'sunita@biznepal.com'
AND NOT EXISTS (
    SELECT 1 FROM jobs j WHERE j.employer_id = u.id AND j.title = 'Junior Java Developer'
);

INSERT INTO jobs (employer_id, title, description, category, location_city, salary_range, job_type, deadline, status)
SELECT u.id, 'Store Supervisor', 'Manage inventory and shift team', 'Retail', 'Itahari', 'NPR 28,000 - 40,000', 'Full-time', DATE_ADD(CURDATE(), INTERVAL 20 DAY), 'pending'
FROM users u WHERE u.email = 'anita@hirehub.com'
AND NOT EXISTS (
    SELECT 1 FROM jobs j WHERE j.employer_id = u.id AND j.title = 'Store Supervisor'
);

INSERT INTO jobs (employer_id, title, description, category, location_city, salary_range, job_type, deadline, status)
SELECT u.id, 'Data Entry Assistant', 'Daily records and filing support', 'Office', 'Biratnagar', 'NPR 20,000 - 28,000', 'Part-time', DATE_ADD(CURDATE(), INTERVAL 10 DAY), 'rejected'
FROM users u WHERE u.email = 'sunita@biznepal.com'
AND NOT EXISTS (
    SELECT 1 FROM jobs j WHERE j.employer_id = u.id AND j.title = 'Data Entry Assistant'
);
