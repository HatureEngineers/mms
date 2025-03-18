//const express = require('express');
//const router = express.Router();
//const pool = require('../../../config/db'); // MySQL connection pool
//
//// ✅ সব ব্যাংকের তালিকা দেখানো (banks টেবিল থেকে)
//router.get('/banks', async (req, res) => {
//  try {
//    const [rows] = await pool.query("SELECT bank_name FROM banks");
//    res.json(rows); // ব্যাংক নামগুলোর তালিকা ফিরিয়ে দেওয়া হবে
//  } catch (error) {
//    res.status(500).json({ error: error.message }); // যদি কোনো ত্রুটি ঘটে
//  }
//});
//
//// ✅ নতুন ব্যাংক যোগ করা (banks টেবিলে ইনসার্ট করা)
//router.post('/add', async (req, res) => {
//  const { bank_name } = req.body;
//
//  if (!bank_name) {
//    return res.status(400).json({ error: "Bank Name প্রয়োজন!" });
//  }
//
//  try {
//    const sql = "INSERT INTO banks (bank_name) VALUES (?)";
//    await pool.query(sql, [bank_name]);
//    res.status(201).json({ message: "Bank সফলভাবে যোগ হয়েছে!" });
//  } catch (error) {
//    res.status(500).json({ error: error.message });
//  }
//});
//
//// ✅ নির্দিষ্ট ব্যাংকের ব্রাঞ্চের তালিকা দেখানো
//router.get('/branches', async (req, res) => {
//  const { bank } = req.query;
//
//  if (!bank) {
//    return res.status(400).json({ error: "Bank parameter is required!" });
//  }
//
//  try {
//    // প্রথমে, ব্যাংকের আইডি বের করুন
//    const [bankRows] = await pool.query("SELECT id FROM banks WHERE bank_name = ?", [bank]);
//    if (bankRows.length === 0) {
//      return res.status(404).json({ error: `No bank found with name: ${bank}` });
//    }
//    const bank_id = bankRows[0].id;
//
//    // এরপর, সংশ্লিষ্ট ব্রাঞ্চগুলোর তালিকা নিন
//    const [rows] = await pool.query("SELECT branch_name FROM branches WHERE bank_id = ?", [bank_id]);
//
//    if (rows.length === 0) {
//      return res.status(404).json({ error: `No branches found for bank: ${bank}` });
//    }
//
//    res.json(rows);
//  } catch (error) {
//    res.status(500).json({ error: error.message });
//  }
//});
//
//// ✅ ব্রাঞ্চ যোগ করা
//router.post('/branches/add', async (req, res) => {
//  const { bank_name, branch_name } = req.body;
//
//  if (!bank_name || !branch_name) {
//    return res.status(400).json({ error: "Bank Name এবং Branch Name প্রয়োজন!" });
//  }
//
//  try {
//    // প্রথমে, ব্যাংকের আইডি বের করুন
//    const [bankRows] = await pool.query("SELECT id FROM banks WHERE bank_name = ?", [bank_name]);
//    if (bankRows.length === 0) {
//      return res.status(404).json({ error: `Bank not found: ${bank_name}` });
//    }
//    const bank_id = bankRows[0].id;
//
//    // branches টেবিলে নতুন ব্রাঞ্চ ইনসার্ট করুন
//    const sql = "INSERT INTO branches (branch_name, bank_id) VALUES (?, ?)";
//    await pool.query(sql, [branch_name, bank_id]);
//    res.status(201).json({ message: "Branch successfully added!" });
//  } catch (error) {
//    console.error("Error adding branch:", error.message);
//    res.status(500).json({ error: error.message });
//  }
//});
//
//module.exports = router;
