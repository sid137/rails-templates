# To use
# rails new appname --skip-gemfile -JTm tiny.cc/rails3

### File templates first, commands after

# Install and configure standard gems
file "Gemfile",<<-END
# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

gem 'rails'

gem "haml-rails"
gem "jquery-rails"

# gem 'aws-s3', :require => 'aws/s3'
# gem 'bcrypt-ruby', :require => 'bcrypt'
# gem 'formtastic'

group :development, :test do
  gem "sqlite3-ruby", :require => 'sqlite3'
  gem "ruby-debug19", :require => 'ruby-debug'

  # Data export
  gem "yaml_db"

  # css framework for dev machine
  gem "compass"

  # model layer, test data generation
  gem "annotate-models"
  gem "factory_girl_rails"
  gem "faker"
  gem "randexp"
  gem "random_data"
  gem 'forgery'

  # testing
  gem 'database_cleaner', :git => 'https://github.com/bmabey/database_cleaner.git'
  
  # controller helper not available for integration tests, so use webrat for now
  # gem "capybara"  

  gem "cucumber-rails"
  gem 'webrat'
  gem "launchy"
  gem "rspec-rails"
  gem 'shoulda-matchers'
  gem "ZenTest"
  gem "autotest-rails"
end
END

# Default application layout
file "app/views/layouts/application.html.haml",<<-END
!!! 
%html(lang='en')
  %head
    %meta(charset='utf-8')

    %title 

    = javascript_include_tag "https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"
    = javascript_include_tag 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js'
    = javascript_include_tag :all
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
        - flash.each do |type, value|
          .flash{ :class => type.to_s }
            = value 
      #main
        = yield
      %footer
        = debug(params)
        = debug(cookies)
END


# Default sass template
file "app/stylesheets/main.sass", <<-END
// API located at: http://compass-style.org/docs/reference/compass/
@import blueprint/reset

$blueprint-grid-columns : 24
$blueprint-grid-width   : 30px
$blueprint-grid-margin  : 10px

$blueprint-grid-outer-width = $blueprint_grid_width + $blueprint_grid_margin
$blueprint-container-size = $blueprint_grid_outer_width * $blueprint_grid_columns - $blueprint_grid_margin 

@import blueprint
@import blueprint/scaffolding

@import "compass/support"
@import "compass/css3/text-shadow"
@import "compass/utilities/lists/horizontal-list"
@import "compass/utilities/links"
@import "compass/utilities/general/min"
@import "compass/utilities/text/replacement"
@import "compass/utilities/lists/inline-block-list"

+blueprint
+blueprint-scaffolding


@mixin horizontal-center($width: 500px) 
  display: block
  width: $width
  margin: 0 auto

header, nav, footer 
  +column($blueprint_grid_columns, true)

#container
  +container
END

# Google analytics partial
file "app/views/layouts/_google_analytics.html.erb", <<-END
<script>
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-XXXXXXX-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
END

run "rm .gitignore"
file ".gitignore", <<-END  
tags
log/*.log  
*.swp
*.swo
.sass-cache
*~
*.cache
*.log
*.pid
tmp/**/*
db/*.sqlite3
db/data.yml
vendor/bundle
END


file "README.md", <<-END
Compile css
    compass watch .

Create Pivotal Tracker project

Create stories, specs and tests

Create heroku and github repos and remotes

Ensure that files listed in SECRETS are never shared publicly
END

file "SECRETS", <<-END
config/initializers/secret_token.rb
config/database.yml
END

# Create git repository
git :init

run "rm README"
run "rm public/index.html"
run "rm app/views/layouts/application.html.erb"
run 'bundle install --path vendor/bundle --binstubs'

# Install haml/sass/compass 
run "compass init rails --css-dir=public/stylesheets --sass-dir=app/stylesheets --images-dir=public/images -x sass --using blueprint/basic"
# no initializer.. causes probs with heroku
run "rm config/initializers/compass.rb"

# Install rspec
generate "rspec:install"
run "echo '--format documentation' >> .rspec"

run "mkdir spec/{routing,models,controllers,views,helpers,mailers,requests}"
run "touch spec/factories.rb"


# Install jquery
run "rails generate jquery:install"

# git:hold_empty_dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")

run "ctags -R"

git :add => "."
git :commit => "-a -m 'Finishing application setup'"
git :branch => "staging"
git :branch => "development"
