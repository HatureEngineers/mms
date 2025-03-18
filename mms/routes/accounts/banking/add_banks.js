const express = require('express');
const router = express.Router();
const db = require('../../../config/db'); // আপনার MySQL সংযোগ ফাইলটি নিশ্চিত করুন

// সব ব্যাংকের নাম পড়া
router.get('/banks', async (req, res) => {
  try {
    const [banks] = await db.execute('SELECT * FROM bank_names');
    res.json(banks);
  } catch (error) {
    console.error('Error fetching banks:', error);
    res.status(500).json({ error: error.message });
  }
});

// নতুন ব্যাংকের নাম যোগ করা
router.post('/banks', async (req, res) => {
  try {
    const { bank_name } = req.body;
    await db.execute('INSERT INTO bank_names (bank_name) VALUES (?)', [bank_name]);
    res.status(201).json({ message: 'Bank name added successfully' });
  } catch (error) {
    console.error('Error adding bank:', error);
    res.status(500).json({ error: error.message });
  }
});

// ব্রাঞ্চ পড়ার জন্য রাউট
router.get('/branches/:bank_id', async (req, res) => {
  try {
    const { bank_id } = req.params;
    const [branches] = await db.execute('SELECT * FROM bank_branches WHERE bank_id = ?', [bank_id]);
    res.json(branches);
  } catch (error) {
    console.error('Error fetching branches:', error);
    res.status(500).json({ error: error.message });
  }
});

// নতুন ব্রাঞ্চ যোগ করা
router.post('/branches', async (req, res) => {
  try {
    const { branch_name, bank_id } = req.body;
    await db.execute('INSERT INTO bank_branches (branch_name, bank_id) VALUES (?, ?)', [branch_name, bank_id]);
    res.status(201).json({ message: 'Bank branch added successfully' });
  } catch (error) {
    console.error('Error adding branch:', error);
    res.status(500).json({ error: error.message });
  }
});


// নতুন ব্যাংক অ্যাকাউন্ট যোগ করা
router.post('/add-bank', async (req, res) => {
  try {
    let { bank_id, branch_id, account_holder, account_number, balance } = req.body;

    console.log("📥 Received Data:", req.body);

    // Ensure bank_id and branch_id are integers
    bank_id = parseInt(bank_id) || null;
    branch_id = parseInt(branch_id) || null;
    balance = parseFloat(balance) || 0.00;

    await db.execute(
      'INSERT INTO banks (bank_id, branch_id, account_holder, account_number, balance) VALUES (?, ?, ?, ?, ?)',
      [bank_id, branch_id, account_holder, account_number, balance]
    );

    res.status(201).json({ message: '✅ Bank account added successfully' });
  } catch (error) {
    console.error('❌ Error adding bank account:', error);
    res.status(500).json({ error: error.message });
  }
});

// অ্যাকাউন্ট আপডেট করা
router.put('/account/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { bank_id, branch_id, account_holder, account_number, balance } = req.body;
    await db.execute(
      'UPDATE banks SET bank_id = ?, branch_id = ?, account_holder = ?, account_number = ?, balance = ? WHERE id = ?',
      [bank_id, branch_id, account_holder, account_number, balance, id]
    );
    res.json({ message: 'Bank account updated successfully' });
  } catch (error) {
    console.error('Error updating bank account:', error); // লগিং ত্রুটি
    res.status(500).json({ error: error.message });
  }
});

// অ্যাকাউন্ট ডিলিট করা
router.delete('/account/:id', async (req, res) => {
  try {
    const { id } = req.params;
    await db.execute('DELETE FROM banks WHERE id = ?', [id]);
    res.json({ message: 'Bank account deleted successfully' });
  } catch (error) {
    console.error('Error deleting bank account:', error); // লগিং ত্রুটি
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
