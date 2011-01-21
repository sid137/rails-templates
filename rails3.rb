# To use
# rails appname -m tiny.cc/rails3


# Create git repository
git :init

# git:hold_empty_dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")


# Install and configure standard gems
file "Gemfile",<<-END
# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

## Bundle edge rails:
gem 'rails', '3.0.3'
gem "sqlite3-ruby", :require => 'sqlite3'

gem "haml-rails"

group :test do
  gem "faker"
  gem "ZenTest"
  gem "rspec-rails" #, :git => "git://github.com/rspec/rspec-rails.git"
end

END


file "app/views/layouts/application.html.haml",<<-END
!!! 
%html(lang='en')
  %head
    %meta(charset='utf-8')

    %title 

    = javascript_include_tag "https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"
    = javascript_include_tag 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js'
    = stylesheet_link_tag "screen", :media => "screen, projection"
    = stylesheet_link_tag "print", :media => "print"

    <!--[if IE]><link href="stylesheets/ie.css" rel="stylesheet" /><![endif]-->
    <!-- HTML5 Shiv http://code.google.com/p/html5shiv/ -->
    <!--[if lt IE 9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script> 
    <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js">IE7_PNG_SUFFIX=".png";</script>
    <![endif]-->

    = favicon_link_tag
    /= render 'layouts/google_analytics'

  %body
    #container
      %header
        - [:error, :success, :notice].each do |type|
            - if flash[type]
                .type= flash[type]
      = yield
END

run "echo 'TODO' > README.md"
run "rm README"
run "rm public/index.html"
run 'bundle install'

# Install haml/sass/compass 
run "compass install blueprint/basic  --css-dir=public/stylesheets --sass-dir=app/stylesheets --images-dir=public/images -x sass"

# Install rspec
run "rails generate rspec:install"

git :add => "."
git :commit => "-a -m 'Finishing application setup'"

