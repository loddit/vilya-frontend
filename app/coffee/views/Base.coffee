define [
  'jquery'
  'backbone'
  'underscore'
], ($, Backbone, _) =>
  class BaseView extends Backbone.View
    
    loadSubView: (selector, viewOrHtml) ->
      $subEl = @$el.find(selector).first()
      if typeof viewOrHtml == 'string'
        $subEl.html viewOrHtml
      else if $subEl[0] == view.el
        viewOrHtml.render()
      else
        $subEl.html viewOrHtml.render().el

    _cachedTemplates: ->
      cachedTemplates = window._TEMPLATES
      if not cachedTemplates
        window._TEMPLATES = cachedTemplates = {}
      return cachedTemplates

    _setCachedTemplate: (name, data) ->
      cachedTemplates = @_cachedTemplates()
      cachedTemplates[name] = _.template(data)

    _loadTemplate: (name) ->
      path = "/templates/#{name}.html"
      return $.get path, (data) =>
        @_setCachedTemplate name, data

    _loadTemplates: (callback)->
      templatesToLoad = @templates || []
      if not templatesToLoad instanceof Array
        templatesToLoad = [templatesToLoad ]
      cachedTemplates = @_cachedTemplates
      deffered = []
      for name in templatesToLoad
        if not cachedTemplates[name]
          deffered.push @_loadTemplate(name)
      $.when.apply(null, deffered).done(callback)

    getTemplate: (name) ->
      if not name in (@templates || [])
        throw new Error("Attempted to access templates '#{name}' before states in templates fields"

    render: ->
      # NOTICE:
      # You should NOT override this method anymore
      # override some of the following method
      #   * beforeRender
      #   * renderContext
      #   * afterRendered
      @_loadTemplates =>
        @_beforeRender =>
          @_renderContext =>
            @_afterRendered()

    _beforeRender: (callback) ->
      if @beforeRender
        @beforeRender.apply this, callback
      else
        callback()
    
    _renderContext: (callback) ->
      if @renderContext
        @renderContext.apply this, callback
      else
        callback()

    _afterRendered: ->
      if @afterRendered
        @afterRendered.apply this



