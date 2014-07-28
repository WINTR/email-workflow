Promise = require("promise")
readFile = Promise.denodeify(require("fs").readFile)
writeFile = Promise.denodeify(require("fs").writeFileSync)
files = [
  "welcome.html"
  "exploring.html"
  "app.html"
  "myallrecipes.html"
]

readFiles = (files, store)->
  # Read
    
  i = 0
  while i < files.length
    readFile("./build/"+files[i], "utf-8").then (html) =>

      headerCSS = '<style type="text/css">' + mq + '</style>'

      mqPos = html.indexOf("</head>")
      output = [
        html.slice(0, mqPos)
        headerCSS
        html.slice(mqPos)
      ].join("")

      store.push output
    i++
  return store

writeFiles = (fileOutput) ->
  # Write
  i = 0
  while i < files.length
    writeFile "./build/mq/"+files[i], fileOutput[i], (err) =>
      throw err  if err
      console.log "File Saved!"
      return
    i++

getMediaQueryCSS = ->
  readFile("./styles/css/styles.css", "utf-8").then (css) ->
    # css.substring()
    startMediaQuery = css.indexOf("@media only screen and")
    mq = css.slice(startMediaQuery)
    allTemplates = []
    readFiles(files, allTemplates).then(data) ->
      console.log data


    
    

  return

module.exports = getMediaQueryCSS

