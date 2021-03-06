gulp       = require 'gulp'
sass       = require 'gulp-sass'
slim       = require 'gulp-slim'
sourcemaps = require 'gulp-sourcemaps'


site_data = require './src/data.json'

path =
  dest:
    css : './assets'
    html: './'
  src:
    sass: './src/sass/**/*.scss'
    scss: './src/sass/**/*.sass'
    slim: './src/slim/*.slim'

# Sass
gulp.task 'sass', ->
  gulp.src [path.src.sass, path.src.scss]
    .pipe sourcemaps.init()
    .pipe sass().on 'error', sass.logError
    .pipe sourcemaps.write('./')
    .pipe gulp.dest path.dest.css

# Slim
gulp.task 'slim', ->
  gulp.src path.src.slim
    .pipe sourcemaps.init()
    .pipe slim
      pretty: true
      data: site_data
      require: 'slim/include'
      options: 'include_dirs=[Dir.pwd, "./src/slim/components"]'
    .pipe gulp.dest path.dest.html

# Watch for file changes
gulp.task 'watch', ->
  # Sass
  gulp.watch(path.src.sass, ['sass']);
  gulp.watch(path.src.scss, ['sass']);

  # Slim
  gulp.watch("./src/slim/*.slim", ['slim'])


gulp.task 'default', ['sass', 'slim']
