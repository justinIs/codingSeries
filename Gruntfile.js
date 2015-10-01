module.exports = function (grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    jst: {
      compile: {
        options: {
          prettify: true,
          processName: function (filepath) {
            var processed = filepath.replace(/^.*[\\\/]/, '');
            return processed.substr(0, processed.length - 5);
          }
        },
        files: {
          "js/templates.js": "templates/**/*.html"
        }
      }
    },
    less: {
      compile: {
        files: {
          "css/index.css": "less/main.less"
        }
      }
    },
    watch: {
      templates: {
        files: ['templates/**/*.html'],
        tasks: ['jst']
      },
      styles: {
        files: ['less/**/*.less']
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-jst');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-less');

  // Default task(s).
  grunt.registerTask('default', ['jst', 'less']);

};