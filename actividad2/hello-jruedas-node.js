var http = require("http");

var port = 8080;
var hostname = 'localhost';

var mongoUrl = 'mongodb://192.168.1.5:27017/test';

const server = http.createServer((req, res) => {
  res.statusode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end(mongoUrl + '\n');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});