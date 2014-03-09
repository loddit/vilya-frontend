define [
  'jquery'
  'backbone'
  'underscore'
], ($, Backbone, _) =>
  class BaseView extends Backbone.View

    load: ->
      @_loadFailed('cancel')
      @dtd = $.Deferred()
      @render()
      return @dtd.promise()

    loadSubView: (selector, viewOrHtml) ->
      $subEl = @$el.find(selector).first()
      if typeof viewOrHtml == 'string'
        $subEl.html viewOrHtml
        return viewOrHtml
      else if $subEl[0] == view.el
        return viewOrHtml.load()
      else
        $subEl.html viewOrHtml.el
        return viewOrHtml.load()

    waitFor: (deferreds..., callback) ->
      callback = callback || (->)
      $.when.apply(null, deferreds).done(callback)

    ready: (callback) ->
      if @dtd and @dtd.state() == 'resolved'
        callback() if callback
        return true
      else
        @waitFor @load(), callback
        return false

    showLoading: (ele) ->
      $ele = ele || @$el
      $ele.html '
      <div class="spinner view-spinner">
        <div class="dot1"></div>
        <div class="dot2"></div>
      </div>
      '

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
      cachedTemplates = @_cachedTemplates()
      deffered = []
      for name in templatesToLoad
        if not cachedTemplates[name]
          deffered.push @_loadTemplate(name)
      if deffered.length
        $.when.apply(null, deffered).done(callback).fail =>
          @loadFailed 'template'
      else
        callback()

    getTemplate: (name) ->
      if not name in (@templates || [])
        throw new Error "Attempted to access templates '#{name}' before announced in templates fields"
      @_cachedTemplates()[name]


    render: ->
      # NOTICE:
      # You should NOT override this method anymore
      # override some of the following method
      #   * beforeRender
      #   * renderContext
      #   * afterRendered
      @_beforeRender =>
        @dtd.notifyWith(this) if @dtd
        @_loadTemplates =>
          @dtd.notifyWith(this) if @dtd
          @_renderContext =>
            @_afterRendered()
            if @dtd
              @dtd.notifyWith(this)
              @dtd.resolve()
      return this

    _beforeRender: (callback) ->
      if @beforeRender
        @beforeRender.call this, callback
        if @beforeRender.length == 0
          callback()
      else
        callback()

    
    _renderContext: (callback) ->
      if @renderContext
        @renderContext.call this, callback
        if @renderContext.length == 0
          callback()
      else
        callback()

    _afterRendered: ->
      if @afterRendered
        @afterRendered.call this

    _loadFailed: (reason) ->
      if @dtd and @dtd.state() == 'pending'
        @dtd.rejectWith(this)
      if @loadFailed
        @loadFailed.call this, reason

  return BaseView

