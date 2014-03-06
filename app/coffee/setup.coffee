require.config
  baseUrl: "/js/",
  distUrl: "/js/tmp/",


define 'jquery', 'lib/jquery.js'
define 'backbone', 'lib/backbone.js'
define 'underscore', 'lib/underscore.js'
define 'modernizer', 'lib/modernizer.js'
define 'retina', 'lib/retina.js'

require ['modernizer', 'retina']

require ['router'], (Router) =>
  window.router = new Router()
