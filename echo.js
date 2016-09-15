var sendStatus = process.env.SENDSTATUS || 200,
  port = process.env.PORT || 8080,
  express = require('express'),
  bodyParser = require('body-parser'),
  bunyan = require('express-bunyan-logger'),
  util = require('util');

var expressLoggerConfig = {
  name: 'echo',
  excludes: ['ip', 'incoming', 'res', 'res-headers', 'response-hrtime', 'short-body'],
  format: ":method :url :user-agent[family] :user-agent[os] :status-code",
  immediate: false,
  genReqId: false
};

var app = express();
app.use(bodyParser.text());
app.use(bunyan(expressLoggerConfig));

app.all('*',function(req,res){
  res.sendStatus(sendStatus);
});

app.listen(port);
