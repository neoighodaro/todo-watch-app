const express = require('express');
const bodyParser = require('body-parser');
const Pusher = require('pusher');

const app = express();
app.use(bodyParser.json());

var pusher = new Pusher({
  appId: 'PUSHER_APP_ID',
  key: 'PUSHER_KEY',
  secret: 'PUSHER_SECRET',
  cluster: 'PUSHER_CLUSTER'
});

app.post('/addItem', function (req, res) {
  pusher.trigger('todo', 'addItem', { id: req.body.id, text: req.body.value, completed:0 });
  res.send(200);
})

var port = process.env.PORT || 5000;
app.listen(port);
