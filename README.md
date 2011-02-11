


# To Use

I added a function to my .zshrc, which gives me shell shortcut to load the rails3.rb template hosted on
github.  

ZSH function to initialize rails apps with templates

file: ~/.zsrhc

    function rapp {
        appname=$1
        template=$2
        rails new $appname --skip-gemfile -JTm https://github.com/sid137/rails-templates/raw/master/${template:-rails3}.rb 
    }


Run the default rails3.rb template by using the shell command
    %  rapp appname


or  run another template named template_name.rb  with
    % rapp appname template_name

