define [
  'jquery'
  'views/base'
  'views/home/overview'
  'views/home/pullrequests'
  'views/home/issues'
], ($, BaseView, OverviewView, PullRequestsView, IssuesView) ->
  class MainPanelView extends BaseView
    events:
      'click .nav>li': 'navigate'

    renderContext: (callback) ->
      @nav = @$el.find '.nav'
      @content = @$el.find '.panel-body'
      @waitFor @switchTab('overview'), callback

    navigate: (event) ->
      $navEle = $ event.currentTarget 
      tabName = $navEle.data 'tab'
      @switchTab tabName

    switchTab: (name) ->
      view = null
      switch name
        when 'pullrequests'
          view = @pullrequestView = @pullrequestView ? new PullRequestsView()
        when 'issues'
          view = @issuesView = @issuesView ? new IssuesView()
      if not view
        name = 'overview'
        view = @overviewView = @overviewView ? new OverviewView() 
      @content.html view.el
      @nav.find('li').removeClass('active')
      @nav.find("li[data-tab=#{name}]").addClass('active')
      return view.load()

