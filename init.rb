REPO = "http://github.com/sid137/rails-templates/raw/master/"

# Create git repository
load_template REPO + "git.rb"

run "echo TODO > README"
run "rm public/index.html"

# Install and configure standard gems
load_template REPO + "gems.rb"


# Finalize setup
rake "db:create"
rake "db:create", :env => "test"
rake "db:migrate"

git :add => "."
git :commit => "-a -m 'Finishing application setup'"
