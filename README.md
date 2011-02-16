
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


or  run another template named template_name.rb  with
    % rapp appname template_name

