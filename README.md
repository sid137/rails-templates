
# Rails Application Templates

## To Use

If you want, you can simply download the rails3.rb template file, and feed it
the rails command as an argument when you generate a new app:

    wget --no-check-certificate 'https://github.com/sid137/rails-templates/raw/master/rails3.rb'
    rails new $appname --skip-gemfile -JTm rails3.rb 


I added a function to my .zshrc, which gives me shell shortcut to load the rails3.rb template hosted on
github.  

ZSH function to initialize rails apps with templates
file: ~/.zsrhc

    function rapp {
        appname=$1
        template=$2
        rails new $appname --skip-gemfile -JTm https://github.com/sid137/rails-templates/raw/master/${template:-rails3}.rb 
    }


With this shell command in place you can then rRun the default rails3.rb template by using the shell command
    %  rapp appname

## Template Actions

This template carries out the following actions when you run it for a new rails
app.

* Installs a default GEMFILE with my normal gems

* Installs a HAML based layout, application.html.haml.  

  -  Layout loads JQuery from Google CDN

  -  Stylesheets 

  - HTML5 shiv to make older brozswers recognize HTML5 styling

  - sets up favicon and google analytics partial

  - renders flashes in <header></header> tag

* Default main.sass file which loads things I use

* Creates a Google Analytics partial

* Creates a .gitignore

* Creates a README.md listing next steps to take

* Creates a SECRETS file listing files to never let sneak into the open public

* Creates a git repository for project

* Installs Compass/Sass to manage css

* Installs rspec and configures it for documentation format

* Creates rspec directories needed for all testing

* Creates an empty spec/factories.rb for using Factory Girl

* Tells git to not ignore empty directories that we want to save

* uses Bundler to install all gems to the project vendor/bundler directory,
  along with shortcuts in the bin directory

* runs ctags to create a ctags file for navigating all of the gems, along with
  the rails source

* Adds all files to the git rerpo

* Finalizes initial commit

* Creates local branches for staging and development


