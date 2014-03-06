define [
  'jquery'
  'backbone'
  # require views
  'views/layout'
  'views/home'
  'views/user'
  'views/project'
], ($, Backbone, LayoutView, HomeView, UserView, ProjectView) =>
  class Router extends Backbone.Router

    routes:
      '/': 'home'
      '/:user': 'user'
      '/:user/:project(/:endpoint)': 'project'

    initialize: ->
      @layout = new LayoutView()
      @loadView  @layout

    home: ->
      new HomeView()

    user: (user) ->
      new UserView user: user

    project: (user, project, endpoint) ->
      new ProjectView
        user: user
        project: project
        endpoint: endpoint

  return Router
