const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// ── Routes ──────────────────────────────────────────────
app.get('/', (req, res) => {
  res.json({
    message: 'Hello from Node.js DevOps App! 🚀',
    version: '1.0.0',
    env: process.env.NODE_ENV || 'development',
  });
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', uptime: process.uptime() });
});

app.get('/api/users', (req, res) => {
  res.json([
    { id: 1, name: 'Alice' },
    { id: 2, name: 'Bob' },
  ]);
});

// ── Start ────────────────────────────────────────────────
const server = app.listen(PORT, () => {
  console.log(`✅  Server running on http://localhost:${PORT}`);
});

module.exports = { app, server };
