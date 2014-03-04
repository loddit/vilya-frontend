require.config
  baseUrl: "/js/",
  distUrl: "/js/tmp/",


define 'jquery', 'lib/jquery.js'
define 'backbone', 'lib/backbone.js'
define 'underscore', 'lib/underscore.js'
define 'modernizer', 'lib/modernizer.js'

require ['main'], (app) =>
  console.log 'Contribute to vilya at https://github.com/douban/code'
