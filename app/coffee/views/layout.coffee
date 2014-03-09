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
        @container = @$el.find '#main-container'
        @loadingView = $ '#page-loading'

      renderContext: (callback)->
        @waitFor @navView.load(), callback

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
            @_hidePageLoading()

      _showPageLoading: ->
        @loadingView.css display:'block'
        @loadingView.fadeIn 400

      _hidePageLoading: ->
        if @loadingView.css('display') == 'none'
          return
        @loadingView.fadeOut 400, =>
          @loadingView.css display:'none'
