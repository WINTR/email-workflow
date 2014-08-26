# Responsive Email Workflow

A starting boilerplate for building responsive emails, using NodeJS and various fancy tools to make life easier.


### Get Started:
- Install [nodeJS](http://nodejs.org/download/)
- Clone this repository: `git clone git@github.com:WINTR/email-workflow.git`
- Run `npm install`
- Configure email settings and recipients in `mailer.coffee`
- Run `gulp` to start all default gulp tasks


### Multiple Email Templates

By default you'll have one email template which will compile to `index.html` in the `./build` and `./build/mq` directories. But you can add as many templates as you'd like. Just create a new file under `./jade/templates/` called `foo.jade`, run `gulp build` and you'll have a new `foo.html` template ready in the build folder.

To configure the send task to send multiple templates, just add each compiled template filename to the `files` array starting on line 135 in gulpfile.coffee. See below for sending tasks.


### Gulp Tasks:

- `gulp` compiles jade and stylus, livereload, and runs build task

- `gulp build` to inline css, add media queries to the head, and construct final HTML/CSS templates ready for emailing.

- `gulp send --file filename` to send an html email to the specified recipient(s)

- `gulp sendAll` to send all email templates to the specified recipient(s)


### Todo:

- Make Ink a bower dependency to stay current with any updates.
- Add HTML & CSS Linting Task
- Add tests (Integrated with Email Client Testing?)


### References:

- [Gulp](http://gulpjs.com/)
- [Nodemailer](http://www.nodemailer.com/)
- [ZURB Ink Email Templates](http://zurb.com/ink/templates.php)
- [Litmus](https://litmus.com) Resources for best practices, and Email Testing Services
