#	> File Name: Gruntfile.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Sunday, November 23, 2014 AM10:42:51 CST

module.exports = (grunt)->
    grunt.initConfig
        simplemocha:
            options:
                compilers: 'coffee:coffee-script'
            all: {src: ['test/**/*.coffee']}
        watch:
            compile:
                options:
                    livereload: true
                files: [
                    'views/**/*.coffee',
                    'views/**/*.sass'
                    'views/**/*.jade'
                ]
                tasks: ['coffee']
        coffee:
            compile:
                files:
                    'views/dist/build.js': 'views/src/coffee/*.coffee'

    grunt.loadNpmTasks 'grunt-simple-mocha'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    grunt.registerTask 'test', 'simplemocha'
    grunt.registerTask 'watch', ['coffee', 'watch']
