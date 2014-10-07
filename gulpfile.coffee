browserify = require 'browserify'
gulp = require 'gulp'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
sequence = require 'gulp-run-sequence'
insert = require 'gulp-insert'
stylus = require 'gulp-stylus'
autoprefixer = require 'autoprefixer-stylus'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
del = require 'del'


# Clean build folder
gulp.task('clean', ->
  del('./build')
)


# Copy all client files except the CSS & script files
gulp.task('copy', ->
  gulp.src([
    './client/**/*.*'
    '!./client/**/*.coffee'
    '!./client/**/*.js'
    '!./client/**/*.styl'
  ])
    .pipe(gulp.dest('./build'))
)


# Stylus files
gulp.task('css', ->
  gulp.src('./client/styles/application.styl')
    .pipe(stylus(
      use: [ autoprefixer() ]
      compress: true
    ))
    .pipe(gulp.dest('./build/styles'))
)


# JS files
gulp.task('js', ->
  # Get the build time
  build = new Date().getTime()

  # Start the bundling
  browserify(
    entries: ['./client/start.coffee']
    extensions: ['.coffee']
  )
  .bundle()
  .pipe(source('bundle.js'))
  .pipe(insert.prepend("var buildTime = #{build};"))
  .pipe(buffer())
  # Need to keep ascii_only: true or else Regex errors will be thrown
  .pipe(uglify({ output: { ascii_only: true } }))

  # Output the minified bundle
  .pipe(gulp.dest('./build'))
)


# Run the default tasks
gulp.task('default', ->
  sequence(
    'clean' # Make sure clean runs before everything else
    ['copy', 'css', 'js']
  )
)


# Run the tasks, minus the cleanup
gulp.task('test-build', ['copy', 'css', 'js'])