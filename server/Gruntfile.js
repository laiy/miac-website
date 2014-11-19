/*
*> File Name: Gruntfile.js
*> Author: LY
*> Mail: ly.franky@gmail.com
*> Created Time: Wednesday, November 19, 2014 PM02:17:38 CST
*/

module.exports = function (grunt) {
    grunt.initConfig({
        simplemocha: {
            options: {
                compilers: "coffee:coffee-script"
            },
            test: {
                src: ["test/**/*.coffee"]
            }
        }
    });
    grunt.loadNpmTasks("grunt-simple-mocha");
    grunt.registerTask("test", "simplemocha");
};

