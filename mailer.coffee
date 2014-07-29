nodemailer = require("nodemailer")
Promise = require "promise"
readFile = Promise.denodeify(require('fs').readFile)




# getTemplate = (callback) ->
  

    # throw err if err
    # console.log html

# readTemplate = ->
#   new Promise (fulfill, reject) ->
#     readFile(filename, "utf8").done (res) ->
#       fs.readFile './build/index.html', 'utf-8', (err, html) ->
#       try
#         return html
#       catch ex
#         reject ex
#       return
#     , reject
#     return

  

# htmlTemplate = getTemplate()
# .then (html)->
#   console.log html


# create reusable transport method (opens pool of SMTP connections)
smtpTransport = nodemailer.createTransport("SMTP",
  service: "Gmail"
  auth:
    user: "jonathan@wintr.us"
    pass: "j0na+haN"
)

# setup e-mail data with unicode symbols



# send mail with defined transport object
sendEmail = (filename)->
  html = readFile('./build/mq/'+filename+'.html', 'utf-8')
  .then (html) ->
    # console.log html
    mailOptions =
      from: "Fred Foo ✔ <foo@blurdybloop.com>" # sender address
      to: "jonathan@wintr.us,hudak.jonathan@gmail.com" # list of receivers
      subject: "AllRecipes Email" # Subject line
      text: "AllRecipes Email" # plaintext body
      html: html # html body
  
    smtpTransport.sendMail mailOptions, (error, response) ->
      if error
        console.log error
      else
        console.log "Message sent: " + response.message
        smtpTransport.close(); # shut down the connection pool, no more messages
      return




  

  


  

module.exports = sendEmail
