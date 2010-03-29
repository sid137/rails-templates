# Create git repository
git :init

# git:hold_empty_dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")


# Install and configure standard gems
file "Gemfile",<<-END
# Edit this Gemfile to bundle your application's dependencies.
source 'http://gemcutter.org'
source 'http://gems.github.com'

## Bundle edge rails:
gem "rails", :git => "git://github.com/rails/rails.git"


#gem "mongo_ext"
#gem "mongoid", :git => "git://github.com/durran/mongoid.git"

#gem "warden"
#gem "devise", "1.1.pre4", :git => "git://github.com/plataformatec/devise.git"


gem "haml"
gem "compass"
#gem "bluecloth"

group :test do
#  gem 'ZenTest'
#  gem "rspec", :git => "git://github.com/rspec/rspec.git"
#  gem "rspec-rails", :git => "git://github.com/rspec/rspec-rails.git"
#  gem 'capybara',         :git => 'git://github.com/jnicklas/capybara.git'
#  gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'
#  gem 'cucumber-rails',   :git => 'git://github.com/aslakhellesoy/cucumber-rails.git'
end

#gem "faker"
group :development do
#  gem "looksee", :group => [:development, :test]
end

#gem "jquery_helpers"
#gem "newrelic_rpm"
END


file "app/views/layouts/application.html.haml",<<-END
!!! 5
%html(xmlns="http://www.w3.org/1999/xhtml")
  %head
    %meta(http-equiv="content-type" content="text/html" charset="utf-8")
    %title Application Template

    = stylesheet_link_tag 'screen.css', :media => 'screen, projection'
    = stylesheet_link_tag 'print.css', :media => 'print'
    /[if lt IE 8]
      = stylesheet_link_tag 'ie.css', :media => 'screen, projection'

    = javascript_include_tag 'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'
    = javascript_include_tag 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js'

    = javascript_include_tag 'http://www.google.com/jsapi?key=ABQIAAAAWE_Mi-8Zmi4wixpIeFXIWxSah9S-j4zSd7OuZVJ9P6HK1pErfhRLys8c9D8s0Q_R-Itr4xemDQHIog', :charset => 'utf-8'


  %body

    %h1 Application Template


    - [:error, :success, :notice].each do |type|
      - if flash[type]
        .type= flash[type]


    = yield
END




run "echo 'TODO' > README"
run "rm public/index.html"

run 'bundle install'

# Install haml/sass/compass 
run "compass --rails -f blueprint . --css-dir=public/stylesheets/ --sass-dir=app/stylesheets"

git :add => "."
git :commit => "-a -m 'Finishing application setup'"

