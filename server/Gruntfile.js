module.exports = function(grunt){
  grunt.initConfig({
    clean: {
      stylesheets: ['client/css/*.css'],
      javascripts: ['client/js/*.js']
    },

    less: {
      options:{
        paths: ['client/src/css']
        // cleancss: true
      },

      compile: {
        files: {
          'client/css/style.css': 'client/src/**/*.less'
        }
      }
    },

    jshint: {
      options: {
        ignores: ['node_modules/**/*', 'client/lib/**/*'],
        laxbreak: true
      },

      beforeConcat: ['**/*.js'],
      afterConcat: ['client/js/build.js']
    },

    concat: {
      options: {
        separator: ';'
      },

      javascripts: {
        src: ['client/src/**/*.js'],
        dest: 'client/js/build.js'
      }
    },

    express: {
      options: {
        port: 3000,
        debug: false
      },
      server: {
        options: {
          script: 'app.js'
        }
      }
    },

    watch: {
      options: {
        spawn: false
      },

      stylesheets: {
        files: ['client/src/**/*.less'],
        tasks: ['less']
      },

      javascripts_frontend: {
        files: ['client/src/**/*.js'],
        tasks: ['jshint:beforeConcat', 'concat', 'jshint:afterConcat', 'express']
      },

      javascripts_server: {
        files: ['**/*.js', '!client/**/*'],
        tasks: ['express']
      },

      jade: {
        files: ['views/**/*.jade'],
        tasks: ['express']
      }
    },
  });

  // 任务加载
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-express-server');

  // 自定义任务
  // grunt.registerTask('default', ['clean', 'less', 'jshint:beforeConcat', 'concat', 'jshint:afterConcat', 'express', 'watch']);
  grunt.registerTask('default', ['jshint:beforeConcat', 'express', 'watch']);

  grunt.registerTask('clearDatabase', 'Clear database...', function(){
    var db = require('./lib/db');
    var done = this.async();

    db.connect(function(){
      db.clear(function(){
        done();
      });
    });
  });

  grunt.registerTask('initialize', 'Initialize database', function(){
    var db = require('./lib/db');
    var done = this.async();

    db.connect(function(){
      db.initialize(function(){
        done();
      });
    });
  });

  grunt.registerTask('reset', ['clearDatabase', 'clean', 'initialize']);
};

