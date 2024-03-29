
#Module dependencies.
express = require('express')
http = require('http')
path = require('path')

server = http.createServer(app)
io = require('socket.io').listen(server);

#controller files
routes = require('./routes')
user = require('./routes/user')

app = express();

#all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(express.cookieParser('your secret here'));
app.use(express.session());
app.use(app.router);
app.use(require('less-middleware')({ src: __dirname + '/public' }));
app.use(express.static(path.join(__dirname, 'public')));

#development only
if ('development' == app.get('env'))
  app.use(express.errorHandler());

#url definitions
app.get('/', routes.index);
app.get('/users', user.list);

http.createServer(app).listen(app.get('port'), () ->
  console.log('Express server listening on port ' + app.get('port'))
)
