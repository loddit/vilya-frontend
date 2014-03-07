define [
  'jquery'
  'views/base'
  'views/nav/layout'
  'views/home/layout'
  'views/user/layout'
  'views/project/layout'],
  ($, BaseView, NavView, HomeView, UserView, ProjectView) ->
    class LayoutView extends BaseView

      initialize: ->
        @navView = new NavView({el:@$el.find('#nav').get(0)})

      renderContext: (callback)->
        @waitFor @navView.load(), callback

      afterRendered: ->
        @container = @$el.find '#main-container'
        console.log 'layout rendered'

      showHome: ->
        @homeView = new HomeView() if not @homeView
        @switchContentViewTo @homeView

      showUser: (name)->
        @userView = new UserView() if not @userView
        @switchContentViewTo @userView

      showProject: (owner, project_name, endpoint) ->
        @projectView = new ProjectView() if not @projectView
        @switchContentViewTo @projectView
      
      switchContentViewTo: (view) ->
        @ready =>
          @container.html view.el
          view.ready =>
            console.log 'content view changed'


        

