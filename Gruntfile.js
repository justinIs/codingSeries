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
          "public/js/templates.js": "public/templates/**/*.html"
        }
      }
    },
    less: {
      compile: {

      }
    },
    watch: {
      templates: {
        files: ['public/templates/**/*.html'],
        tasks: ['jst']
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-jst');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-less');

  // Default task(s).
  grunt.registerTask('default', ['jst', 'less']);

};