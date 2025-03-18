const express = require('express');
const cors = require('cors');

const studentsRoutes = require('../routes/students/students');
const bankingRoutes = require('../routes/accounts/banking/add_banks.js');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/students', studentsRoutes);
app.use('/banking', bankingRoutes); // ব্যাংক সম্পর্কিত API যুক্ত করা

module.exports = app;
