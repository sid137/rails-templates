


# To Use

I added a function to .wshrc, which loads the rails3.rb template hosted on
github.  URL based templates don't currently load due to Rails 3 bug

Shortcut to initialize rails apps with templates
    function rapp {
        appname=$1
        template=$2
        rails new $appname -JTm https://github.com/sid137/rails-templates/raw/master/${template:-rails3}.rb 
    }


