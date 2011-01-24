


# To Use

I added a function to my .zshrc, which gives me shell shortcut to load the rails3.rb template hosted on
github.  URL based templates don't currently load due to Rails 3 bug

Shortcut to initialize rails apps with templates
    function rapp {
        appname=$1
        template=$2
        rails new $appname -JTm https://github.com/sid137/rails-templates/raw/master/${template:-rails3}.rb 
    }


Run the default rails3.rb template by using the shell command
    %  rapp appname


or  run another template named template_name.rb  with
    % rapp appname template_name

