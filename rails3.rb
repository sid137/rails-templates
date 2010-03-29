REPO = "http://github.com/sid137/rails-templates/raw/master/"

def load(template)
  load_template REPO + template 
end



# Create git repository
load  "git.rb"


inside( 'config' ) do
  run "cp database.yml database.yml.default"
  run "cp environment.rb environment.rb.default"
end 


# Install haml/sass/compass 
apply "http://www.compass-style.org/rails/installer"

run "compass --rails -f blueprint . --css-dir=public/stylesheets/ --sass-dir=app/stylesheets"


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




run "echo 'TODO' > README"
run "rm public/index.html"


git :add => "."
git :commit => "-a -m 'Finishing application setup'"

