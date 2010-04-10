# To use
# rails appname -m tiny.cc/rails3


# Create git repository
git :init

# git:hold_empty_dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")




# Install haml/sass/compass 
run "compass --rails -f blueprint . --css-dir=public/stylesheets/ --sass-dir=app/stylesheets"


# Install and configure standard gems
file "Gemfile",<<-END
# Edit this Gemfile to bundle your application's dependencies.
source 'http://gemcutter.org'
source 'http://gems.github.com'

## Bundle edge rails:
gem "rails", :git => "git://github.com/rails/rails.git"
gem "sqlite3-ruby"

#gem "bson_ext"
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




run "echo 'TODO' > README"
run "rm public/index.html"

run 'bundle install'

git :add => "."
git :commit => "-a -m 'Finishing application setup'"

