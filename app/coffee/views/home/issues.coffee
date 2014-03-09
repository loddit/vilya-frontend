define [
  'jquery'
  'views/base'
], ($, BaseView) ->
  class LayoutView extends BaseView
    templates: [
      'home_issues'
    ]

    beforeRender: (callback) ->
      @showLoading()
      setTimeout callback, 1000

    renderContext:  ->
      template = @getTemplate 'home_issues'
      @$el.html template()

  return LayoutView
