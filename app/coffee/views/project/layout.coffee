define [
  'jquery'
  'views/base'
], ($, BaseView) ->
  class LayoutView extends BaseView
    templates: [
      'project_layout'
    ]

    renderContext: ->
      template = @getTemplate 'project_layout'
      @$el.html template()

  return LayoutView
