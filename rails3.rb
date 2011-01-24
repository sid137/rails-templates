# To use
# rails new appname --skip-gemfile -JTm tiny.cc/rails3

# Create git repository
git :init


# Install and configure standard gems
file "Gemfile",<<-END
# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

## Bundle edge rails:
gem 'rails', '3.0.3'
gem "sqlite3-ruby", :require => 'sqlite3'

gem "haml-rails"

group :test do
  gem "annotate-models"
  gem "capybara"
  gem "factory_girl_rails"
  gem "faker"
  gem "launchy"
  gem "rspec-rails" #, :git => "git://github.com/rspec/rspec-rails.git"
  gem "ZenTest"
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
    = stylesheet_link_tag "main", :media => "screen, projection"
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
      #main
        = yield
      %footer
END


file "app/stylesheets/main.sass", <<-END
// This import applies a global reset to any page that imports this stylesheet.
@import blueprint/reset
// To configure blueprint, edit the partials/_base.sass file.
@import partials/base
// Import all the default blueprint modules so that we can access their mixins.
@import blueprint
// Import the non-default scaffolding module.
@import blueprint/scaffolding

// Generate the blueprint framework according to your configuration:
@import "compass/support"
@import "compass/css3/text-shadow"
@import "compass/utilities/lists/horizontal-list"
@import "compass/utilities/links"
@import "compass/utilities/general/min"
@import "compass/utilities/text/replacement"
@import "compass/utilities/lists/inline-block-list"

+blueprint
+blueprint-scaffolding

header, nav, footer 
  +column($blueprint_grid_columns, true)

#container
  +container
END

run "echo 'TODO' > README.md"
run "rm README"
run "rm public/index.html"
run 'bundle install'

# Install haml/sass/compass 
run "compass init rails --css-dir=public/stylesheets --sass-dir=app/stylesheets -images-dir=public/images -x sass"
  # ran a second time so I can get my preferred screen.sass starter file
run "compass install blueprint/basic  --css-dir=public/stylesheets --sass-dir=app/stylesheets --images-dir=public/images -x sass --force"
  # no initializer.. causes probs with heroku
run "rm config/initializers/compass.rb"

# Install rspec
generate "rspec:install"
run "mkdir spec/{routing,models,controllers,views,helpers,mailers,requests}"

# git:hold_empty_dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")

git :add => "."
git :commit => "-a -m 'Finishing application setup'"

