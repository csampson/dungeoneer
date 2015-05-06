'use strict';

var del = require('del');

var source = require('vinyl-source-stream'),
    buffer = require('vinyl-buffer');

var gulp       = require('gulp'),
    gulpUtil   = require('gulp-util'),
    uglify     = require('gulp-uglify'),
    sourcemaps = require('gulp-sourcemaps');
    
var browserify = require('browserify'),
    watchify   = require('watchify');

var stylus = require('gulp-stylus'),
    nib    = require('nib');

var config = {
  debug: gulpUtil.env.type !== 'production'
};

var scriptBundler = browserify({
  entries: './app/assets/javascripts/application.js',
  debug: config.debug
});

function bundleScripts(options) {
  var bundler = options.watch ? watchify(scriptBundler) : scriptBundler,
      stream  = bundler.bundle();

  if (options.watch) {
    bundler.on('update', function() {
      console.log('Re-bundling scripts...'); // TODO: built-in way to handle this logging..?
      bundleScripts({ watch: false });
    });
  }

  if (config.debug) {
    stream.on('error', gulpUtil.log.bind(gulpUtil, 'Browserify Error'));
  }

  return stream
    .pipe(source('application.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init({ loadMaps: true }))
    .pipe(uglify())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./public/javascripts'));
}

gulp.task('clean-css', function() {
  return del('./public/stylesheets/**/*.css');
});

gulp.task('bundle-css', ['clean-css'], function () {
  return gulp.src('./app/assets/stylesheets/application.styl')
    .pipe(sourcemaps.init())
    .pipe(stylus({ use: [nib()], compress: true }))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./public/stylsheets/'));
});

gulp.task('watch-css', ['bundle-css'], function() {
  gulp.watch('./app/assets/stylesheets/**/*.styl', ['bundle-css']);
});

gulp.task('clean-js', function() {
  return del('./public/javascripts/**/*.js');
});

gulp.task('bundle-js', ['clean-js'], function() {
  bundleScripts({ watch: false });
});

gulp.task('watch-js', ['bundle-js'], function() {
  bundleScripts({ watch: true });
});

gulp.task('bundle', ['bundle-css', 'bundle-js']);
gulp.task('bundle-watch', ['watch-css', 'watch-js']);
