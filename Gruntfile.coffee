module.exports = (grunt) ->

  grunt.initConfig

    mochaTest:
      server:
        src: ['test/server/**/*.coffee']

    coffee:
      options:
        sourceMap: true
      dist:
        files: [
          {
            expand: true
            cwd: 'src'
            src: ['**/*.coffee']
            dest: 'dist'
            ext: '.js'
          }
        ]

    watch:
      test:
        files: [
          'src/**/*.coffee'
          'test/**/*.coffee'
        ]
        tasks: ['build', 'test']
      build:
        files: [
          'src/**/*.coffee'
        ]
        tasks: ['build']


  require('load-grunt-tasks')(grunt)

  grunt.registerTask('build', ['coffee:dist'])
  grunt.registerTask('test-server', ['build', 'mochaTest:server'])
  grunt.registerTask('test', ['test-server'])

