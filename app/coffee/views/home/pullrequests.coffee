define [
  'jquery'
  'views/base'
], ($, BaseView) ->
  class LayoutView extends BaseView
    templates: [
      'home_pullrequests'
    ]

    beforeRender: (callback) ->
      @showLoading()
      setTimeout callback, 1000

    renderContext:  ->
      template = @getTemplate 'home_pullrequests'
      @$el.html template()

  return LayoutView
