# To use
# rails new appname --skip-gemfile -JTm tiny.cc/rails31

### File templates first, commands after

# Install and configure standard gems
run "rm Gemfile"
file "Gemfile",<<-END
# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
gem 'rails', '3.1.1'


#######################################################
# Web Servers
gem "thin"


#######################################################
# Database Layer
gem "pg"
#gem "mongoid"
#gem "bson_ext"
#gem "squeel"


#######################################################
# Infrastructure Gems
#
# Sends notifications of errors on Production app
gem "airbrake"
#gem "resque", :require => 'resque/server'
# We need to use the heroku gem if we have any autoscaling calls to heroku
# workers
#gem "heroku"

# Amazon Webservices gem
#gem "aws-sdk"#, :git => "git clone git://github.com/amazonwebservices/aws-sdk-for-ruby.git"



#######################################################
# Model Layer Gems
#
# Default model values
# https://github.com/FooBarWidget/default_value_for
gem "default_value_for"

# allows model and sitewide settings
# https://github.com/100hz/rails-settings
#gem "rails-settings", :git => "git://github.com/100hz/rails-settings.git"



#######################################################
# View Layer Gems
# For form.
gem 'formtastic'
gem "haml-rails"
gem "jquery-rails"
# Gems used only for assets and not required
# in production environments by default.
gem 'twitter-bootstrap-rails', :git => 'http://github.com/seyhunak/twitter-bootstrap-rails.git'

group :assets do
  gem 'less'
  gem 'less-rails', :git => 'git://github.com/metaskills/less-rails.git'
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end



#######################################################
# Controller Layer Gems
# Gem to abstract away the dplication common in standard restful controllers
# gem 'inherited_resources', :git => "git://github.com/josevalim/inherited_resources.git"


#######################################################
# Routing Gems

# allows us to have seo friendly urls for our objects
# gem "friendly_id", :git => "https://github.com/norman/friendly_id.git"



#######################################################
# Feature Gems
#
# Used to simplify user registrations and logins
# Pined to ref, as there is problem on devise HEAD
gem "devise"#, :git => "git://github.com/plataformatec/devise.git"

# Gem for uploading images.  More flexible than "paperclip"
# fog is for storing files on Amazon, Google...
# remotipart is for uploading files with AJAX
#gem "carrierwave", :git => 'git://github.com/jnicklas/carrierwave.git'
#gem "fog"
#gem 'remotipart', '0.3.4'

# Used to that we can resize images uploaded through carrierwave, using
# ImageMagick
#gem "rmagick"



# Social Media Gems FB Connect, FB, and Twitter
#gem "faraday", :git => "git://github.com/technoweenie/faraday.git"
#gem "omniauth", '0.2.6' #:git => "git://github.com/intridea/omniauth.git"# ,:ref => ""
#gem "fb_graph"
#gem "twitter"#, :git => 'git://github.com/jnunemaker/twitter.git'


group :development, :test do
  gem 'sqlite3'
  gem "ruby-debug19", :require => 'ruby-debug'

  gem "guard"
  gem "guard-bundler"
  gem "guard-rails", :git => "git://github.com/johnbintz/guard-rails.git"
  gem "guard-rspec"
  gem "guard-shell"
  gem "guard-livereload"
  gem 'rb-fsevent', :require => false 
  gem "growl"

  # Easily create database models for site simulation
  gem "factory_girl_rails"

  # Useful for fake data generation
  gem "faker"
  gem "randexp"
  gem "random_data"
  gem 'forgery'
  gem "lorempixum", :require => 'lorempixum'

  gem "taps"
  #gem "heroku-rails", :git => "git://github.com/railsjedi/heroku-rails.git"
  gem "heroku-rails", :git => "git://github.com/sid137/heroku-rails.git"

  # nice table displays in Rails console
  gem "hirb"

  # Allows us to push the local development database up to Heroku, and pull the
  # heroku db down locally
  gem "yaml_db"

  gem "escape_utils"

  gem "rails-footnotes"

  gem "selenium-webdriver"
  gem "rack-test"
  gem "capybara", :require => 'capybara/rspec'
  gem "launchy"
  #gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'

  # Pretty printed test output
  gem 'turn', :require => false

  gem "rspec-rails"# , '2.6.0' #, '2.5.0'
  #gem 'shoulda-matchers', :git => 'git://github.com/thoughtbot/shoulda-matchers.git'
  #gem 'shoulda-matchers', :git => 'git://github.com/sid137/shoulda-matchers.git'
  gem "ZenTest"
  gem "autotest-rails"
end
END

file "Termfile",<<-END
window do
  run "vim"

  tab ''

  tab do
    run "rails console"
  end

  # Add one for pg as well
  
  tab do
    mongo_lockfile = '/data/db/mongod.lock'
    if File.exists?(mongo_lockfile)
      File.unlink mongo_lockfile
      run "mongod --repair"
    end
    run "mongod"
  end

  tab do
    run "guard"
  end
end

END

file "app/views/layouts/_javascripts.html.haml",<<-END
= javascript_include_tag "application"
= yield :javascript
/= render 'layouts/google_analytics'
END

run "rm app/assets/javascripts/application.js"
file "app/assets/javascripts/application.js",<<-END
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
END

run "rm app/assets/stylesheets/application.css"
file "app/assets/stylesheets/application.css",<<-END
/*
 * This is a manifest file that'll automatically include all the stylesheets available in this directory
 * and any sub-directories. You're free to add application-wide styles to this file and they'll appear at
 * the top of the compiled file, but it's generally better to create a new file per style scope.
 *= require bootstrap
 *= require_self
 *= require_tree . 
*/

/* Override some defaults */
html, body {
  background-color: #eee;
}
body {
  padding-top: 40px; /* 40px to make the container go all the way to the bottom of the topbar */
}
.container > footer p {
  text-align: center; /* center align it with the container */
}
.container {
  width: 820px; /* downsize our container to make the content feel a bit tighter and more cohesive. NOTE: this removes two full columns from the grid, meaning you only go to 14 columns and not 16. */
}

/* The white background content wrapper */
.content {
  background-color: #fff;
  padding: 20px;
  margin: 0 -20px; /* negative indent the amount of the padding to maintain the grid system */
  -webkit-border-radius: 0 0 6px 6px;
      -moz-border-radius: 0 0 6px 6px;
          border-radius: 0 0 6px 6px;
  -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
      -moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
          box-shadow: 0 1px 2px rgba(0,0,0,.15);
}

/* Page header tweaks */
.page-header {
  background-color: #f5f5f5;
  padding: 20px 20px 10px;
  margin: -20px -20px 20px;
}

/* Styles you shouldn't keep as they are for displaying this base example only */
.content .span10,
.content .span4 {
  min-height: 500px;
}
/* Give a quick and non-cross-browser friendly divider */
.content .span4 {
  margin-left: 0;
  padding-left: 19px;
  border-left: 1px solid #eee;
}

.topbar .btn {
  border: 0;
}

END

# Default application layout
file "app/views/layouts/application.html.haml",<<-END
!!! 
%html(lang='en')
  %head
    %meta(charset='utf-8')
    %title 
    /Le HTML5 shim, for IE6-8 support of HTML elements 
    /[if lt IE 9]
      %script(src="http://html5shim.googlecode.com/svn/trunk/html5.js")
    = stylesheet_link_tag "application"
    = favicon_link_tag

  %body
    .topbar
      .fill
        .container
          = link_to "Project Name", '#', :class => 'brand'
          %ul.nav
            %li.active= link_to 'Home', '#'
            %li= link_to 'About', '#'
            %li= link_to 'Contact', '#'

    .container
      .content
        .page-header
          = render 'layouts/flashes'
        .row
          = yield
      %footer
        = debug(params)
        = debug(cookies)
    = render 'layouts/javascripts'
END

file "Guardfile", <<-END
# A sample Guardfile
# More info at https://github.com/guard/guard#readme
# :project_path: path to the compass project directory (from guard working directory)
# :configuration_file: path to your compass configuration file (from guard working directory)
guard 'compass', :configuration_file => 'config/compass.rb' do
  watch(/^app\/stylesheets\/(.*)\.s[ac]ss/)
end


# https://github.com/mockko/livereload#readme
#
# :api_version => '1.4'    # default '1.6'
# :host => '127.3.3.1'     # default '0.0.0.0'
# :port => '12345'         # default '35729'
# :apply_js_live => false  # default true
# :apply_css_live => false # default true
# :grace_period => 0.5     # default 0 (seconds)
guard 'livereload' do
  watch(%r{app/.+\.(erb|haml)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{(public/|app/assets).+\.(css|js|html)})
  watch(%r{(app/assets/.+\.css)\.scss}) { |m| m[1] }
  watch(%r{(app/assets/.+\.js)\.coffee}) { |m| m[1] }
  watch(%r{config/locales/.+\.yml})
end



# https://github.com/guard/guard-rails
#
# :port is the port number to run on (default 3000)
# :environment is the environment to use (default development)
# :start_on_start will start the server when starting Guard (default true)
# :force_run kills any process that's holding open the listen port before attempting to (re)start Rails (default false).
# :daemon runs the server as a daemon, without any output to the terminal that ran guard (default false).
# :timeout waits this number of seconds when restarting the Rails server before reporting there's a problem (default 20).
guard 'rails', :force_run => true, do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
  watch('db/schema.rb')
end

# Runs bundle
guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end
END



file "Procfile", <<-END
web: bundle exec thin -D start -p $PORT 
END

file "app/views/layouts/_flashes.html.haml", <<-END
- flash.each do |type, value|
  .flash{ :class => type.to_s }
    = value 
END

file "app/views/layouts/_head.html.haml", <<-END
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
.DS_Store
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

file ".rvmrc", <<-END
#!/bin/zsh
# /* vim: set filetype=sh : */   

source ./setup/boot.sh
END

file "spec/support/shared_connection.rb", <<-END
# see following URL thread for more info
# http://groups.google.com/group/ruby-capybara/browse_thread/thread/248e89ae2acbf603/122ed17a45f3b397?lnk=raot#122ed17a45f3b397
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection 
END




# Create git repository
git :init

run "rm README"
run "rm public/index.html"
run "rm app/views/layouts/application.html.erb"
run 'bundle install --path vendor/bundle'


# Install rspec
generate "rspec:install"
run "echo '--format documentation' >> .rspec"

# Install Devise
generate "devise:install"
generate "devise User"

# Generate a default home controller
generate :controller,  "home",  "index"
route  "root :to => 'home#index'"


# run 'mkdir spec/{routing,models,controllers,views,helpers,mailers,requests}'
run "touch spec/factories.rb"
run "git clone git://github.com/sid137/setup.git"


rake "db:migrate"


# git:hold_empty_dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")

run "ctags -R"

git :add => "."
git :commit => "-a -m 'Finishing application setup'"
git :branch => "dev"
