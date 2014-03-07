define [
  'jquery'
  'views/base'
], ($, BaseView) ->
  class LayoutView extends BaseView
    templates: [
      'home_layout'
    ]

    renderContext: ->
      template = @getTemplate 'home_layout'
      @$el.html template()

  return LayoutView
