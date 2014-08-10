module.exports = function(grunt){
  grunt.initConfig({
    clean: {
      stylesheets: ['public/stylesheets/*.css'],
      javascripts: ['public/javascripts/*.js']
    },

    less: {
      options:{
        paths: ['public/src/css']
        // cleancss: true
      },

      compile: {
        files: {
          'public/stylesheets/style.css': 'public/src/**/*.less'
        }
      }
    },

    jshint: {
      options: {
        ignores: ['node_modules/**/*', 'public/lib/**/*'],
        laxbreak: true
      },

      beforeConcat: ['**/*.js'],
      afterConcat: ['public/javascripts/build.js']
    },

    concat: {
      options: {
        separator: ';'
      },

      javascripts: {
        src: ['public/src/**/*.js'],
        dest: 'public/javascripts/build.js'
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
        files: ['public/src/**/*.less'],
        tasks: ['less']
      },

      javascripts_frontend: {
        files: ['public/src/**/*.js'],
        tasks: ['jshint:beforeConcat', 'concat', 'jshint:afterConcat', 'express']
      },

      javascripts_server: {
        files: ['**/*.js', '!public/**/*'],
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

