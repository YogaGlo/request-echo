var sendStatus = process.env.SENDSTATUS || 200,
  port = process.env.PORT || 8080,
  express = require('express'),
  bodyParser = require('body-parser'),
  util = require('util');

var app = express();
app.use(bodyParser.text());

app.all('*',function(req,res){
  var logentry = {
    url: req.url,
    method: req.method,
    query: req.query,
    headers: req.headers,
    body: req.body
  }

  var logstring = JSON.stringify(util.inspect(logentry, false, null)).replace(/\\n/g, "");

  console.log(logstring);

  res.sendStatus(sendStatus);
});

app.listen(port);
