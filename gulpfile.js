'use strict';

var del = require('del');

var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');

var gulp       = require('gulp');
var gulpUtil   = require('gulp-util');
var uglify     = require('gulp-uglify');
var sourcemaps = require('gulp-sourcemaps');
var imagemin   = require('gulp-imagemin');
var watch      = require('gulp-watch');
var batch      = require('gulp-batch');
var plumber    = require('gulp-plumber');
    
var browserify = require('browserify');
var watchify   = require('watchify');

var stylus = require('gulp-stylus');
var nib    = require('nib');

var config = {
  debug: gulpUtil.env.type !== 'production'
};

var scriptBundler = browserify({
  entries: './app/assets/javascripts/application.js',
  debug: config.debug
});

function bundleScripts(options) {
  var bundler = options.watch ? watchify(scriptBundler) : scriptBundler;
  var stream  = bundler.bundle();

  if (options.watch) {
    bundler.on('update', function() {
      console.log('Re-bundling scripts...'); // TODO: built-in way to handle this logging..?
      bundleScripts({ watch: false });
    });

    return;
  }

  if (config.debug) {
    stream.on('error', gulpUtil.log.bind(gulpUtil, 'Browserify Error'));
  }

  return stream
    .pipe(plumber())
    .pipe(source('application.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init({ loadMaps: true }))
    .pipe(uglify())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./public/javascripts'));
}

gulp.task('clean-images', function() {
  return del('./public/images/**/*');
});

gulp.task('clean-css', function() {
  return del('./public/stylesheets/**/*');
});

gulp.task('clean-js', function() {
  return del('./public/javascripts/**/*');
});

gulp.task('bundle-css', ['clean-css'], function () {
  return gulp.src('./app/assets/stylesheets/application.styl')
    .pipe(plumber())
    .pipe(sourcemaps.init())
    .pipe(stylus({ use: [nib()], compress: true }))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./public/stylesheets'));
});

gulp.task('bundle-images', ['clean-images'], function() {
  return gulp.src('./app/assets/images/**/*')
    .pipe(plumber())
    .pipe(imagemin({
        progressive: true,
        svgoPlugins: [{removeViewBox: false}]
    }))
    .pipe(gulp.dest('./public/images'));
});

gulp.task('bundle-js', ['clean-js'], function() {
  bundleScripts({ watch: false });
});

gulp.task('watch-images', ['bundle-images'], function() {
  watch('./app/assets/images/**/*', function () {
    gulp.start('bundle-images');
  });
});

gulp.task('watch-css', ['bundle-css'], function() {
  watch('./app/assets/stylesheets/**/*.styl', function() {
    gulp.start('bundle-css');
  });
});

gulp.task('watch-js', ['bundle-js'], function() {
  bundleScripts({ watch: true });
});

gulp.task('bundle', ['bundle-images', 'bundle-css', 'bundle-js']);
gulp.task('bundle-watch', ['watch-images', 'watch-css', 'watch-js']);
