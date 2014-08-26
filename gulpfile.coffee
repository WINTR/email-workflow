gulp = require("gulp")
$ = require('gulp-load-plugins')()
# non-gulp
pngcrush = require('imagemin-pngcrush')
send = require("./mailer")
addMediaQueries = require("./addMediaQueries")
runSequence  = require 'run-sequence'
args  = require('yargs').argv



# --------------------------------------------------------
# Path Configurations
# --------------------------------------------------------

paths =

  jade: "./jade/**/**/*.jade"
  jadeTemplates: "./jade/templates/*.jade"
  html: "./*.html"
  stylus: "styles/**/*.styl"
  stylusIndex: "./styles/styles.styl"
  css: "styles/css/"
  images: "images/*"
  build: "./build"



# Direct errors to notification center
handleError = ->
   $.plumber errorHandler: $.notify.onError ->
      $.util.beep()
      "Error: <%= error.message %>"


#--------------------------------------------------------
# BUILD Tasks
#--------------------------------------------------------


gulp.task "inline", ->
  gulp.src(paths.html)
    .pipe($.inlineCss(preserveMediaQueries: true))
    .pipe gulp.dest(paths.build)



gulp.task "plaintext", ->
  gulp.src(paths.html)
    .pipe($.html2txt())
    .pipe gulp.dest(paths.build + "/plaintext")
  return





#--------------------------------------------------------
# Compile Stylus
#--------------------------------------------------------
gulp.task "stylus", ->
  gulp.src paths.stylusIndex
    .pipe handleError()
    .pipe $.stylus()
    .pipe $.autoprefixer()
    .pipe $.combineMediaQueries()
    .pipe gulp.dest paths.css 
    .pipe $.livereload()


#--------------------------------------------------------
# Compile Jade
#--------------------------------------------------------
gulp.task "jade", ->
  gulp.src paths.jadeTemplates
    .pipe $.jade(pretty:true)
    .pipe gulp.dest './'



# --------------------------------------------------------
# Connect to server
# --------------------------------------------------------
gulp.task "connect", ->
  $.connect.server 
    root: __dirname



#--------------------------------------------------------
# Watch for changes and reload page
#--------------------------------------------------------
gulp.task "reload", ->
  gulp.src(paths.html).pipe $.livereload()
  return


gulp.task "watch", ->
  server = $.livereload()
  $.livereload.listen()

  gulp.watch paths.stylus, ["stylus"]
  gulp.watch paths.jade, ["jade"]


  gulp.watch [
    paths.html
    paths.css
  ], ["reload", "build"]

  return




gulp.task "clean", require("del").bind(null, [paths.build])

# --------------------------------------------------------
# BUILD
# --------------------------------------------------------

gulp.task "build", ->

  runSequence [
    "inline"
    "addMediaQueries"
  ]


# --------------------------------------------------------
# SEND EMAIL (configure in ./mailer.coffee)
# --------------------------------------------------------

# Files to email
files = [
  "index.html"
]

filename = args.file
gulp.task "send", ->
  send(filename)

gulp.task "sendAll", ->
  i = 0
  while i < files.length
    file = files[i].split(".")
    send(file[0])
    i++


# --------------------------------------------------------
# Add Media Queries to Head (configure in ./addMediaQueries.coffee)
# --------------------------------------------------------
gulp.task "addMediaQueries", ->
  addMediaQueries(files)


# --------------------------------------------------------
# Connect to server
# --------------------------------------------------------

gulp.task "default", [
  "connect"
  "watch"
]
