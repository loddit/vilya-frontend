fs = require 'fs'
util = require 'util'

module.exports = (grunt) ->

  require('time-grunt')(grunt)

  # register external tasks
  grunt.loadNpmTasks 'grunt-ozjs'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-connect-proxy'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-env'
  
  APP_PATH = 'app'
  DEV_BUILD_PATH = 'build'
  PRODUCTION_BUILD_PATH = "production"
  DEV_SERVER_PORT = 9000
  CODE_SERVER_HOST = 'localhost'
  CODE_SERVER_PORT = 8000

  grunt.initConfig
    connect:
      server:
        options:
          port: DEV_SERVER_PORT
          base: DEV_BUILD_PATH
          middleware: (connect, options, middlewares) =>
            middlewares.unshift require('grunt-connect-proxy/lib/utils').proxyRequest
            return middlewares
        proxies:
          context: '/api'
          host: CODE_SERVER_HOST
          port: CODE_SERVER_PORT
          https: false
          changeOrigin: false
          xforward: false

    stylus:
      development:
        options:
          paths: ["#{APP_PATH}/stylus"]
          import: ['consts']
        files:
          'build/css/main.css': ["#{APP_PATH}/stylus/main.styl"]

    coffee:
      development:
        files: [
          expand: true,
          cwd: "#{APP_PATH}/coffee",
          src: '*.coffee',
          dest: "#{DEV_BUILD_PATH}/js/",
          ext: '.js'
        ]

    copy:
      development:
        files: [
          # copying user static files
          {
            expand: true
            cwd: "#{APP_PATH}/"
            src: [
              'index.html'
              'templates/**'
              'images/**'
            ]
            dest: 'build/'
          }

          # copying lib js
          {
            expand: true
            flatten: true
            cwd: 'bower_components'
            src: [
              'ozjs/oz.js'
              'jquery/jquery.js'
              'backbone/backbone.js'
              'modernizr/modernizr.js'
              'underscore/underscore.js'
              'retina.js/src/retina.js'
            ]
            dest: 'build/js/lib'
          }

          # copying bootstrap's css and fonts
          {
            expand: true
            cwd: 'bower_components/bootstrap/dist'
            src: ['css/**', 'fonts/**']
            dest: 'build/css/bootstrap'
          }

          # copying font awesome's css and fonts
          {
            expand: true
            cwd: 'bower_components/fontawesome'
            src: ['css/**', 'fonts/**']
            dest: 'build/css/fontawesome'
          }

        ]

    ozma:
      development:
        src: 'build/js/setup.js'
        config:
          baseUrl: 'build/js/'
          destUrl: 'build/.tmp/js/'
          loader: 'lib/oz.js'

    watch:
      stylus:
        files: "#{APP_PATH}/stylus/**/*.styl"
        tasks: 'stylus:development'
      coffee:
        files: "#{APP_PATH}/coffee/**/*.coffee"
        tasks: [
          'coffee:development'
          'ozma:development'
        ]
      copy:
        files: [
          "#{APP_PATH}/index.html",
          "#{APP_PATH}/templates/*.html",
          "#{APP_PATH}/images/*",
        ]
        tasks: 'copy:development'


  grunt.registerTask 'development', [
    'copy:development'
    'stylus:development'
    'coffee:development'
    'ozma:development'
  ]

  grunt.registerTask 'default', [
    'development'
    'configureProxies:server'
    'connect:server'
    'watch'
  ]
