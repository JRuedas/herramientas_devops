var http = require("http");

var port = 8080;
var hostname = 'localhost';

const server = http.createServer((req, res) => {
  res.statusode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello Jonatan Ruedas Mora!\n');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});