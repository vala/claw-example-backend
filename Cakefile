fs            = require 'fs'
sqlite        = require 'sqlite3'
{spawn, exec} = require 'child_process'


# ANSI Terminal Colors.
bold = red = green = reset = ''
unless process.env.NODE_DISABLE_COLORS
  bold  = '\x1B[0;1m'
  red   = '\x1B[0;31m'
  green = '\x1B[0;32m'
  reset = '\x1B[0m'

log = (message, color = reset, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

task 'build', 'Build Node app', ->
  src = spawn 'coffee', ['-cw', '-o', 'models', 'src/models']
  src.stdout.on 'data', (data) ->  log data.toString().trim(), green

  src = spawn 'coffee', ['-cw', '-o', 'routes', 'src/routes']
  src.stdout.on 'data', (data) -> log data.toString().trim(), green

  src = spawn 'coffee', ['-cw', '-o', '.', 'src/app.coffee']
  src.stdout.on 'data', (data) -> log data.toString().trim(), green


task 'run:dev', 'Run the example server while re-building coffee sources', ->
  invoke('build')
  server = spawn 'node', ['app.js']
  server.stdout.on 'data', (data) -> log data.toString().trim(), bold
  server.stderr.on 'data', (data) -> log data.toString().trim(), red

task 'db:create', 'Loads database schema', ->
  log "Loading database schema ..."

  db = new sqlite.Database __dirname + '/db/dev.db', ->
    db.serialize ->
      db.run """
        CREATE TABLE IF NOT EXISTS projects (
          id integer NOT NULL,
          data text,
          PRIMARY KEY (id)
        )
      """

      db.run """
        CREATE TABLE IF NOT EXISTS users (
          id INTEGER NOT NULL,
          email VARCHAR(255),
          password VARCHAR(255),
          PRIMARY KEY (id)
        )
      """

      log "Loaded !"

  db.close()

task 'db:seed', 'Loads fake data into dev.db', ->
  log "Loading fake data into database ..."

  projectsData = require(__dirname + "/db/seeds/projects.json").projects
  usersData = require(__dirname + "/db/seeds/users.json").users

  db = new sqlite.Database __dirname + '/db/dev.db', ->
    db.serialize ->

      # Load projects
      stmt = db.prepare "INSERT INTO projects (data) VALUES (?)"
      stmt.run(JSON.stringify project) for project in projectsData
      stmt.finalize()

      # Load users
      stmt = db.prepare "INSERT INTO users (email, password) VALUES (?, ?)"
      stmt.run(user.email, user.password) for user in usersData
      stmt.finalize()

      log "Done !"

    db.close()

