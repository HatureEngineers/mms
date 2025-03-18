const express = require('express');
const router = express.Router();
const pool = require('../../../config/db');

// 🔹 ১. সব লেনদেন দেখানো
router.get('/', (req, res) => {
    db.query('SELECT * FROM bank_deposit', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// 🔹 ২. নতুন ডিপোজিট করা
router.post('/add', (req, res) => {
    const { account_holder, account_number, depositor_name, description, amount, bank_id, transaction_date } = req.body;
    if (!account_number || !amount || !bank_id || !transaction_date) {
        return res.status(400).json({ error: "সঠিক তথ্য প্রদান করুন!" });
    }

    db.query(
        'INSERT INTO bank_deposit (account_holder, account_number, depositor_name, description, amount, bank_id, transaction_date) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [account_holder || null, account_number, depositor_name || null, description || null, amount, bank_id, transaction_date],
        (err, result) => {
            if (err) return res.status(500).json({ error: err.message });
            res.status(201).json({ message: '✅ নতুন ডিপোজিট সফল হয়েছে' });
        }
    );
});

// 🔹 ৩. ডিপোজিট আপডেট করা
router.put('/edit/:id', (req, res) => {
    const { amount, description } = req.body;
    const { id } = req.params;

    db.query('UPDATE bank_deposit SET amount = ?, description = ? WHERE id = ?', [amount, description, id],
        (err, result) => {
            if (err) return res.status(500).json({ error: err.message });
            res.json({ message: '✅ ডিপোজিট আপডেট হয়েছে' });
        }
    );
});

// 🔹 ৪. ডিপোজিট মুছে ফেলা
router.delete('/delete/:id', (req, res) => {
    const { id } = req.params;

    db.query('DELETE FROM bank_deposit WHERE id = ?', [id],
        (err, result) => {
            if (err) return res.status(500).json({ error: err.message });
            res.json({ message: '✅ ডিপোজিট মুছে ফেলা হয়েছে' });
        }
    );
});

module.exports = router;
