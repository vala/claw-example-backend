models = require "../models"
_ = require "underscore"

exports.index = (req, res) ->
  res.send(
    "Welcome to Claw example backend man."
  )

###
Users
###

exports.users = (req, res) ->
  models.db (err, conn) ->
    models.User.using(conn).all (err, users) ->
      res.send(
        count: users.length,
        users: ({ id: user.id, email: user.email } for user in users)
      )

exports.user = (req, res) ->
  models.db (err, conn) ->
    models.User.using(conn).where(id: req.params.id).first (err, user) ->
      res.send(
        id: user.id
        email: user.email
      )

###
Projects routes
###

projectJSON = (projects) ->
  ary = _.isArray(projects)
  parseProject = (project) ->
    data = project.data
    base = { id: project.id }
    if data then _.extend(base, JSON.parse data) else base

  if ary
    ps = []
    for index, project of projects
      p = parseProject(project)
      ps.push(p) if p
    ps
  else
    _.extend { id: projects.id }, JSON.parse projects.data

exports.projects = (req, res) ->
  models.db (err, conn) ->
    models.Project.using(conn).all (err, projects) ->
      res.send(
        count: projects.length,
        projects: projectJSON(projects)
      )

exports.project = (req, res) ->
  models.db (err, conn) ->
    models.Project.using(conn).where(id: req.params.id).first (err, project) ->
      res.send(
        projectJSON(project)
      )
