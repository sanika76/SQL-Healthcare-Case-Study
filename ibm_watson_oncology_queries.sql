-- 1. Show all patients and their diagnosis. 
SELECT 
name, 
diagnosis 
FROM Patients;

-- 2. Display only the names of female patients.
SELECT 
name 
FROM Patients 
WHERE gender = 'F';

-- 3. Count how many patients are recorded in the database.
SELECT 
COUNT(*) AS total_patients 
FROM Patients;

-- 4. Show all medical conditions recorded in the system.
SELECT 
patient_id, 
medical_condition 
FROM Medical_History;

-- 5. Find all patients who have allergies.
SELECT p.name, mh.allergies
FROM Patients p
JOIN Medical_History mh ON p.patient_id = mh.patient_id
WHERE mh.allergies IS NOT NULL AND mh.allergies <> '';

-- 6. Count patients by cancer stage.
SELECT stage, COUNT(*) AS total_patients
FROM Patients
GROUP BY stage;

-- 7. Show patients recommended for a treatment with confidence above 85.
SELECT p.name, t.treatment_name, wr.confidence_score
FROM Watson_Recommendations wr
JOIN Patients p ON wr.patient_id = p.patient_id
JOIN Treatment_Options t ON wr.treatment_id = t.treatment_id
WHERE wr.confidence_score > 85;

-- 8. Find the number of patients grouped by gender.
SELECT gender, COUNT(*) AS total
FROM Patients
GROUP BY gender;

-- 9. Show patient names in uppercase.
SELECT 
UPPER(name) AS patient_name 
FROM Patients;

-- 10. Show patients with more than one medical condition.
SELECT p.name, COUNT(mh.medical_condition) AS condition_count
FROM Medical_History mh
JOIN Patients p ON mh.patient_id = p.patient_id
GROUP BY p.name
HAVING condition_count > 1;

-- 11. Which treatment has the highest average confidence score?
SELECT t.treatment_name, AVG(wr.confidence_score) AS avg_confidence
FROM Watson_Recommendations wr
JOIN Treatment_Options t ON wr.treatment_id = t.treatment_id
GROUP BY t.treatment_name
ORDER BY avg_confidence DESC
LIMIT 1;

-- 12. Show the youngest patient and their diagnosis.
SELECT name, age, diagnosis
FROM Patients
ORDER BY age ASC
LIMIT 1;

-- 13. Show unique diagnoses among all patients.
SELECT 
DISTINCT diagnosis 
FROM Patients;

-- 14. Show patients who are over 60 years old and their treatments.
SELECT p.name, p.age, t.treatment_name
FROM Patients p
JOIN Watson_Recommendations wr ON p.patient_id = wr.patient_id
JOIN Treatment_Options t ON wr.treatment_id = t.treatment_id
WHERE p.age > 60;

-- 15. Show total patients linked to each treatment option.
SELECT t.treatment_name, COUNT(wr.patient_id) AS total_patients
FROM Treatment_Options t
JOIN Watson_Recommendations wr ON t.treatment_id = wr.treatment_id
GROUP BY t.treatment_name;