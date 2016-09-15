var express = require('express'),
    bodyParser = require('body-parser'),
    util = require('util');

var app = express();
app.use(bodyParser.text());

app.all('*',function(req,res){
  logentry = {
    url: req.url,
    method: req.method,
    query: req.query,
    headers: req.headers,
    body: req.body
  }

  console.log(util.inspect(logentry, false, null));

  res.sendStatus(200);
});

app.listen(8080);
