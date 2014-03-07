define [
  'jquery'
  'backbone'
  # require views
  'views/layout'
], ($, Backbone, LayoutView) =>
  class Router extends Backbone.Router

    routes:
      '': 'home'
      ':user': 'user'
      ':user/:project(/:endpoint)': 'project'

    initialize: ->
      @layout = new LayoutView({el: $('#mainlayout').get(0)})
      @layout.load()
      Backbone.history.start {}

    home: ->
      @layout.showHome()

    user: (user) ->
      @layout.showUser user

    project: (user, project, endpoint) ->
      @layout.showProject user, project, endpoint

  return Router
