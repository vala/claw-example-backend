#
# Module dependencies.
#
express = require "express"
fs      = require "fs"
routes  = require "./routes"
http    = require "http"
path    = require "path"

app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("29é2eéçzdj!12E,zda912jdazça^ée$éeùavdnsxskqéçé")
  app.use express.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index

app.get "/users", routes.users
app.get "/users/:id", routes.user

app.get "/projects", routes.projects
app.get "/projects/:id", routes.project

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")