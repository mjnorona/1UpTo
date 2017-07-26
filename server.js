var express = require('express'),
  bodyParser = require('body-parser'),
  mongoose = require('mongoose'),
  port = 8000,
  app = express();
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
mongoose.connect('mongodb://localhost/calendar');

var Schema = mongoose.Schema;

var GroupSchema = new mongoose.Schema({
  name: { type: String, required: [true, 'group name requied'] },
  members: { type: [String], required: [true, 'members required'] },
}, { timestamps: true });
var Group = mongoose.model('groups', GroupSchema)

// Index
app.get('/', function(req, res){
  Group.find(function(err, data){
    if(err) console.log(err);
    res.send(data);
  }).sort({'createdAt': -1})
})
// Form for new groups
app.get('/new', function(req, res){
  res.render('new')
})
app.get('/:name', function(req, res){
  Group.find({name: req.params.name}, function(err, data){
    if(err) {console.log(err);}
    res.send(data[0].members);
  })
})
// Create group
app.post('/create', function(req, res){
  Group.find({name: req.body.name}, function(err, data){
    if(err) {console.log(err);}
    else if (data.length > 0 ){ // if group name exist, append to members
      Group.update({name: req.body.name}, {$push: {'members': req.body.members}}, function(err, data){
        if(err) {console.log(err);}
        console.log(data);
      })
    }
    else { // if group name doesn't exist, create new group
      Group.create(req.body, function(err, data){
        if(err) {console.log(err);}
      })
    }
    res.redirect('/')
  })
})

app.listen(port, function(){
  console.log('running on', port);
})
