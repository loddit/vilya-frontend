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
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-env'
  
  APP_PATH = 'app'
  DEV_BUILD_PATH = 'build'
  PRODUCTION_BUILD_PATH = "production"
  DEV_SERVER_PORT = 9000
  
  grunt.initConfig
    connect:
      server:
        options:
          port: DEV_SERVER_PORT
          base: DEV_BUILD_PATH

    stylus:
      development:
        options:
          paths: "#{APP_PATH}/stylus"
          import: ['consts']
          files:
            'build/css/main.css': "#{APP_PATH}/stylus/*.styl"

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
        files: "#{APP_PATH}/stylus/*.styl"
        tasks: 'stylus:development'
      coffee:
        files: "#{APP_PATH}/coffee/*.coffee"
        tasks: 'coffee:development'
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
    'connect:server'
    'watch'
  ]
