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
                files: [
                    'views/src/coffee/**/*.coffee'
                    'views/src/sass/**/*.sass'
                ]
                options:
                    spawn: false
                tasks: ['coffee', 'sass']
        coffee:
            glob_to_multiple:
                expand: true,
                flatten: true,
                cwd: 'views/src/coffee',
                src: ['**/*.coffee']
                dest: 'views/bin/js',
                ext: '.js'
        browserSync:
            dev:
                bsFiles:
                    src: 'views/**/*'
                options:
                    proxy: 'localhost:2333'
                    watchTask: true
        sass:
            dist:
                files: [
                    expand: true
                    cwd: 'views/src/sass/'
                    src: '**/*.sass'
                    dest: 'views/bin/css'
                    ext: '.css'
                ]

    grunt.loadNpmTasks 'grunt-simple-mocha'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-browser-sync'
    grunt.loadNpmTasks 'grunt-contrib-sass'

    grunt.registerTask 'test', 'simplemocha'
    grunt.registerTask 'default', ['browserSync', 'watch']
