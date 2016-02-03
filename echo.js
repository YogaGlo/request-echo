var express = require('express'),
    bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.text());
app.listen(8080);

app.post('/echo',function(req,res){
  console.log({ 
    headers: req.headers, 
    body: req.body
  });
  res.sendStatus(200);
});
