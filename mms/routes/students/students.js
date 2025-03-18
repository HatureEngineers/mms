const express = require('express');
const db = require('../../config/db');

const router = express.Router();

router.post("/add-student", async (req, res) => {
  const connection = await db.getConnection(); // Get a database connection
  await connection.beginTransaction(); // Start a transaction

  try {
    const {
      userId, // Ensure userId is passed
      admissionDate,
      admissionType,
      gender,
      studentName,
      birthRegNo,
      dob,
      age,
      email,
      bloodGroup,
      isOrphan,
      isDisabled,
      isPoor,
      residenceType,
      guardianName,
      guardianRelation,
      guardianPhone,
      fatherName,
      fatherPhone,
      fatherNID,
      fatherOccupation,
      motherName,
      motherPhone,
      motherNID,
      motherOccupation,
      additionalPhone,
      permanentAddress,
      presentAddress
    } = req.body;

    // Convert financial status flags into SET format
    let financialStatus = [];
    if (isOrphan) financialStatus.push("orphan");
    if (isDisabled) financialStatus.push("handicapped");
    if (isPoor) financialStatus.push("poor");
    financialStatus = financialStatus.length > 0 ? financialStatus.join(",") : null;

    // Step 1: Insert into `students` table
    const studentQuery = `
      INSERT INTO students (
        userId, admission_date, admission_type, gender, name, birth_registration, date_of_birth, age, 
        email, blood_group, financial_status, residence_type, guardian_name, guardian_relation, guardian_phone
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const [studentResult] = await connection.query(studentQuery, [
      userId, admissionDate, admissionType, gender, studentName, birthRegNo, dob, age,
      email, bloodGroup, financialStatus, residenceType, guardianName, guardianRelation, guardianPhone
    ]);

    const studentId = studentResult.insertId; // Get newly inserted student's ID

    // Step 2: Insert into `parents` table
    const parentQuery = `
      INSERT INTO parents (
        student_id, father_name, father_phone, father_nid, father_profession,
        mother_name, mother_phone, mother_nid, mother_profession, additional_phone
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    await connection.query(parentQuery, [
      studentId, fatherName, fatherPhone, fatherNID, fatherOccupation,
      motherName, motherPhone, motherNID, motherOccupation, additionalPhone
    ]);

    // Step 3: Insert addresses (both permanent and present)
    const addressQuery = `
      INSERT INTO addresses (student_id, address_type, division, district, thana, post_office, village, house) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;

    if (permanentAddress) {
      await connection.query(addressQuery, [
        studentId, "permanent", permanentAddress.division, permanentAddress.district, permanentAddress.thana,
        permanentAddress.postOffice, permanentAddress.village, permanentAddress.house
      ]);
    }

    if (presentAddress) {
      await connection.query(addressQuery, [
        studentId, "present", presentAddress.division, presentAddress.district, presentAddress.thana,
        presentAddress.postOffice, presentAddress.village, presentAddress.house
      ]);
    }

    await connection.commit(); // Commit transaction
    res.status(201).json({ success: true, message: "Student added successfully!" });

  } catch (error) {
    await connection.rollback(); // Rollback on error
    console.error("Error adding student:", error);
    res.status(500).json({ success: false, message: "Internal Server Error" });

  } finally {
    connection.release(); // Release the database connection
  }
});

module.exports = router;
