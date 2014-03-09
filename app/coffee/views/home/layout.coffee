define [
  'jquery'
  'views/base'
  'views/home/main-panel'
  'views/home/side-projects'
], ($, BaseView, MainPanelView, SideProjectsView) ->
  class LayoutView extends BaseView
    templates: [
      'home_layout'
    ]

    renderContext: (callback) ->
      template = @getTemplate 'home_layout'
      @$el.html template()
      @mainPanel = new MainPanelView el: @$el.find('#main-panel')[0]
      @sideProjectsPanel = new SideProjectsView el: @$el.find('#side-projects')[0]
      @sideProjectsPanel.load()
      @waitFor @mainPanel.load(), callback

