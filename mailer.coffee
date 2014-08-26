nodemailer = require("nodemailer")
Promise = require "promise"
readFile = Promise.denodeify(require('fs').readFile)

# create reusable transport method (opens pool of SMTP connections)
smtpTransport = nodemailer.createTransport("SMTP",
  service: "Gmail"
  auth:
    user: ""
    pass: ""
)

# send mail with defined transport object
sendEmail = (filename)->
  html = readFile('./build/mq/'+filename+'.html', 'utf-8')
  .then (html) ->
    # console.log html
    mailOptions =
      from: "Fred Foo ✔ <foo@blurdybloop.com>" # sender address
      to: "your@email.com" # list of receivers
      subject: "Responsive Email" # Subject line
      text: "Responsive Email" # plaintext body
      html: html # html body
  
    smtpTransport.sendMail mailOptions, (error, response) ->
      if error
        console.log error
      else
        console.log "Message sent: " + response.message
        smtpTransport.close(); # shut down the connection pool, no more messages
      return




  

  


  

module.exports = sendEmail
