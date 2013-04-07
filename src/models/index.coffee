exports.persist = persist = require "persist"
exports.type    = type    = persist.type

exports.Project = Project = persist.define "project",
  data: type.STRING

exports.User = User = persist.define "user",
  email: type.STRING
  password: type.STRING

exports.db = (cb) ->
  persist.connect(
    driver: 'sqlite3', filename: 'db/dev.db', trace: true
    cb
  )