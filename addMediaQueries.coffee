Q = require("q")
fs = require("fs")
readFile = Q.denodeify(fs.readFile)
writeFile = Q.denodeify(fs.writeFile)


getMobileCSS = ->
  readFile("./styles/css/styles.css", "utf-8").then (css) ->
    # css.substring()
    startMediaQuery = css.indexOf("@media only screen and")
    return css.slice(startMediaQuery)

createEmailHTML = (file, css) ->
  readFile("./build/"+file, "utf-8").then (html) =>
  
    headerCSS = '<style type="text/css">' + css + '</style>'
  
    mqPos = html.indexOf("</head>")

    return [
      html.slice(0, mqPos)
      headerCSS
      html.slice(mqPos)
    ].join("")

createFile = (file, html) ->

  writeFile "./build/mq/"+file, html, (err) =>
    throw err  if err
    console.log file+" Saved!"
    return

module.exports = (files) ->
  css = getMobileCSS()
  .then (css)->
    files.map (file) ->
      html = createEmailHTML(file, css)
      .then (html) ->
        createFile(file, html)


