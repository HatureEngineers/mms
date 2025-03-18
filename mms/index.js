require('dotenv').config();
const server = require('./server/server');

const port = process.env.PORT || 3000;

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
