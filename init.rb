REPO = "http://github.com/sid137/rails-templates/raw/master/"
def load(template)
  load_template REPO + template 
end




# Create git repository
load  "git.rb"

run "echo TODO > README"
run "rm public/index.html"

# Install and configure standard gems
load "gems.rb"

# Install authlogic a
load "authlogic.rb"
# Finalize setup
rake "db:create"
rake "db:create", :env => "test"
rake "db:migrate"

git :add => "."
git :commit => "-a -m 'Finishing application setup'"
