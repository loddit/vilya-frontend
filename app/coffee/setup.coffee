require.config
  baseUrl: "/js/",
  distUrl: "/js/tmp/",

define 'underscore', 'lib/underscore.js'
define 'modernizr', 'lib/modernizr.js'
define 'retina', 'lib/retina.js'


define 'jquery-src', 'lib/jquery.js'
define 'jquery', ['jquery-src'], ->
  return window.jQuery


define 'backbone-src', 'lib/backbone.js'
define 'backbone', ['backbone-src'], ->
  Backbone.inhert = Backbone.View.extend
  return Backbone

require ['router', 'modernizr', 'retina'], (Router) =>
  window.router = new Router()
