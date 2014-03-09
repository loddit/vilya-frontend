define [
  'jquery'
  'views/base'
], ($, BaseView) ->
  class LayoutView extends BaseView
    templates: [
      'home_overview'
    ]

    beforeRender: (callback) ->
      @showLoading()
      setTimeout callback, 1000

    renderContext:  ->
      template = @getTemplate 'home_overview'
      @$el.html template()

  return LayoutView
