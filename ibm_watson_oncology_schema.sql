DROP DATABASE IF EXISTS ibm_watson_oncology;
CREATE DATABASE ibm_watson_oncology;
USE ibm_watson_oncology;

-- 1) Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    age INT NOT NULL,
    gender ENUM('M','F','O') NOT NULL,
    diagnosis VARCHAR(100) NOT NULL,
    stage VARCHAR(20) NOT NULL
);

-- 2) Medical_History (fixed: column name changed to medical_condition)
CREATE TABLE Medical_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    medical_condition VARCHAR(120),
    allergies VARCHAR(120),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- 3) Clinical_Trials
CREATE TABLE Clinical_Trials (
    trial_id INT PRIMARY KEY AUTO_INCREMENT,
    trial_name VARCHAR(120) NOT NULL,
    cancer_type VARCHAR(80) NOT NULL,
    drug_name VARCHAR(80) NOT NULL,
    success_rate DECIMAL(5,2) NOT NULL -- percentage (0-100)
);

-- 4) Treatment_Options
CREATE TABLE Treatment_Options (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    cancer_type VARCHAR(80) NOT NULL,
    treatment_name VARCHAR(120) NOT NULL,
    recommended_stage VARCHAR(40) NOT NULL
);

-- 5) Watson_Recommendations
CREATE TABLE Watson_Recommendations (
    rec_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    treatment_id INT NOT NULL,
    confidence_score DECIMAL(5,2) NOT NULL,
    explanation VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (treatment_id) REFERENCES Treatment_Options(treatment_id)
);

-- =====================
-- INSERT DATA
-- =====================

-- Patients (20 rows)
INSERT INTO Patients (name, age, gender, diagnosis, stage) VALUES
('Anjali Kulkarni', 45, 'F', 'Breast Cancer', 'Stage II'),
('Ramesh Gupta', 60, 'M', 'Lung Cancer', 'Stage III'),
('Priya Nair', 52, 'F', 'Breast Cancer', 'Stage I'),
('Vikram Desai', 67, 'M', 'Colorectal Cancer', 'Stage II'),
('Sneha Patil', 34, 'F', 'Cervical Cancer', 'Stage I'),
('Arjun Mehta', 58, 'M', 'Prostate Cancer', 'Stage II'),
('Neha Sharma', 49, 'F', 'Ovarian Cancer', 'Stage III'),
('Karan Singh', 41, 'M', 'Lymphoma', 'Stage II'),
('Pooja Rao', 56, 'F', 'Breast Cancer', 'Stage III'),
('Rahul Verma', 63, 'M', 'Lung Cancer', 'Stage IV'),
('Isha Joshi', 39, 'F', 'Melanoma', 'Stage II'),
('Sameer Khan', 54, 'M', 'Colorectal Cancer', 'Stage III'),
('Divya Iyer', 47, 'F', 'Breast Cancer', 'Stage II'),
('Amit Kulkarni', 50, 'M', 'Pancreatic Cancer', 'Stage II'),
('Meera Shah', 62, 'F', 'Gastric Cancer', 'Stage III'),
('Rohit Bhat', 36, 'M', 'Lymphoma', 'Stage I'),
('Kavita Mishra', 43, 'F', 'Ovarian Cancer', 'Stage II'),
('Suresh Reddy', 70, 'M', 'Prostate Cancer', 'Stage III'),
('Tanvi Gokhale', 29, 'F', 'Cervical Cancer', 'Stage II'),
('Nikhil Jain', 57, 'M', 'Leukemia', 'Stage II');

-- Medical_History (20 rows - using medical_condition column)
INSERT INTO Medical_History (patient_id, medical_condition, allergies) VALUES
(1, 'Diabetes Type 2', 'Penicillin'),
(2, 'Hypertension', 'None'),
(3, 'Asthma', 'Sulfa Drugs'),
(4, 'Hyperlipidemia', 'None'),
(5, 'Thyroid Disorder', 'Iodine'),
(6, 'Hypertension', 'Aspirin'),
(7, 'Diabetes Type 2', 'None'),
(8, 'Autoimmune Disorder', 'Latex'),
(9, 'Anemia', 'None'),
(10, 'Chronic Bronchitis', 'Dust'),
(11, 'Eczema', 'None'),
(12, 'Kidney Stones', 'NSAIDs'),
(13, 'Migraine', 'None'),
(14, 'Pancreatitis (history)', 'Shellfish'),
(15, 'GERD', 'None'),
(16, 'No Significant History', 'None'),
(17, 'PCOS', 'None'),
(18, 'Arthritis', 'None'),
(19, 'No Significant History', 'None'),
(20, 'No Significant History', 'None');

-- Clinical_Trials (20 rows)
INSERT INTO Clinical_Trials (trial_name, cancer_type, drug_name, success_rate) VALUES
('BRCA-2023 Alpha', 'Breast Cancer', 'Trastuzumab-A', 76.50),
('BRCA-2024 Bravo', 'Breast Cancer', 'Pertuzumab-B', 78.20),
('LUNG-KEYNOTE-1', 'Lung Cancer', 'Pembrolizumab', 67.10),
('LUNG-IMPOWER-2', 'Lung Cancer', 'Atezolizumab', 64.80),
('CRC-FOXFIRE', 'Colorectal Cancer', 'Bevacizumab', 59.40),
('CRC-OPTIMOX', 'Colorectal Cancer', 'Oxaliplatin', 61.30),
('OVAR-ICON7', 'Ovarian Cancer', 'Bevacizumab', 62.70),
('OVAR-SOLO1', 'Ovarian Cancer', 'Olaparib', 74.10),
('MEL-CHECKMATE', 'Melanoma', 'Nivolumab', 69.90),
('MEL-COMBINE', 'Melanoma', 'Ipilimumab', 63.00),
('PRST-PROTECT', 'Prostate Cancer', 'Abiraterone', 65.40),
('PRST-ENZAMET', 'Prostate Cancer', 'Enzalutamide', 68.30),
('LYMPH-RCHOP', 'Lymphoma', 'Rituximab', 71.25),
('LEUK-ALL-Study', 'Leukemia', 'Imatinib', 73.60),
('CERV-KEYNOTE', 'Cervical Cancer', 'Pembrolizumab', 66.20),
('GAST-TAG', 'Gastric Cancer', 'Trastuzumab', 58.10),
('PANC-FOLFIRINOX', 'Pancreatic Cancer', 'FOLFIRINOX', 52.90),
('PANC-GEMCIS', 'Pancreatic Cancer', 'Gemcitabine', 49.80),
('LUNG-OSIMERT', 'Lung Cancer', 'Osimertinib', 72.40),
('BRCA-KI67', 'Breast Cancer', 'Palbociclib', 70.50);

-- Treatment_Options (20 rows)
INSERT INTO Treatment_Options (cancer_type, treatment_name, recommended_stage) VALUES
('Breast Cancer', 'Chemotherapy (AC-T regimen)', 'Stage II'),
('Breast Cancer', 'Targeted Therapy (HER2+)', 'Stage I-II'),
('Breast Cancer', 'Hormone Therapy (Tamoxifen)', 'Stage I-III'),
('Lung Cancer', 'Immunotherapy (PD-1 inhibitor)', 'Stage III-IV'),
('Lung Cancer', 'Targeted EGFR Therapy', 'Stage II-III'),
('Colorectal Cancer', 'FOLFOX Chemotherapy', 'Stage II-III'),
('Colorectal Cancer', 'Targeted Anti-VEGF', 'Stage III'),
('Ovarian Cancer', 'Platinum-based Chemo', 'Stage III'),
('Ovarian Cancer', 'PARP Inhibitor', 'Stage II-III'),
('Melanoma', 'Immune Checkpoint Inhibitor', 'Stage II-III'),
('Prostate Cancer', 'Androgen Deprivation Therapy', 'Stage II-III'),
('Prostate Cancer', 'AR-targeted Therapy', 'Stage III'),
('Lymphoma', 'R-CHOP Regimen', 'Stage I-III'),
('Leukemia', 'TKI Therapy', 'Stage II'),
('Cervical Cancer', 'Chemo-Radiotherapy', 'Stage II'),
('Gastric Cancer', 'Trastuzumab + Chemo', 'Stage II-III'),
('Pancreatic Cancer', 'FOLFIRINOX', 'Stage II'),
('Pancreatic Cancer', 'Gemcitabine + Nab-Paclitaxel', 'Stage II-III'),
('Breast Cancer', 'Surgery + Adjuvant Therapy', 'Stage I'),
('Lung Cancer', 'Chemo + Radiation', 'Stage III');

-- Watson_Recommendations (20 rows)
INSERT INTO Watson_Recommendations (patient_id, treatment_id, confidence_score, explanation) VALUES
(1, 2, 92.00, 'HER2+ indicators; aligns with BRCA-2024 Bravo'),
(2, 4, 88.00, 'Stage III NSCLC; KEYNOTE data support'),
(3, 19, 95.00, 'Early stage; surgery + adjuvant recommended'),
(4, 6, 81.50, 'Stage II CRC; FOLFOX recommended'),
(5, 15, 84.20, 'Chemo-radiotherapy effective in Stage II'),
(6, 11, 86.70, 'ADT standard in Stage II'),
(7, 8, 87.30, 'Platinum-based regimen for advanced stage'),
(8, 13, 90.10, 'R-CHOP standard for Stage II lymphoma'),
(9, 1, 83.40, 'AC-T appropriate for Stage III'),
(10, 20, 82.60, 'Concurrent chemoradiation for Stage III'),
(11, 10, 89.50, 'Checkpoint inhibitor effective Stage II'),
(12, 7, 80.75, 'Anti-VEGF beneficial in Stage III'),
(13, 3, 88.90, 'Hormone therapy indicated (ER+)'),
(14, 17, 77.25, 'FOLFIRINOX for fit patients Stage II'),
(15, 16, 79.80, 'HER2+ gastric regimen'),
(16, 13, 85.60, 'Early-stage lymphoma responds to R-CHOP'),
(17, 9, 86.40, 'PARP inhibitor in BRCA mutation'),
(18, 12, 84.10, 'AR-targeted therapy in advanced prostate'),
(19, 15, 90.80, 'Chemo-radiotherapy suitable for Stage II'),
(20, 14, 91.20, 'TKI standard of care in CML/ALL variants');

SELECT * FROM ibm_watson_oncology.clinical_trials;
SELECT * FROM ibm_watson_oncology.medical_history;
SELECT * FROM ibm_watson_oncology.patients;
SELECT * FROM ibm_watson_oncology.treatment_options;
SELECT * FROM ibm_watson_oncology.watson_recommendations;