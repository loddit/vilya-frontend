define [
  'jquery'
  'views/base'
], ($, BaseView) ->
  class SideProjectView extends BaseView
    templates: [
      'side_projects'
    ]

    beforeRender: (callback) ->
      @showLoading()
      setTimeout callback, 2000

    renderContext:  ->
      template = @getTemplate 'side_projects'
      @$el.html template()

