REPO = "http://github.com/sid137/rails-templates/raw/master/"

def load(template)
  load_template REPO + template 
end


install_authlogic = yes?("Install Authlogic?")
install_facebook =  yes?("Install Facebook?")


# Create git repository
load  "git.rb"


inside( 'config' ) do
  run "cp database.yml database.yml.default"
  run "cp environment.rb environment.rb.default"
end 





# Install and configure standard gems
load "gems.rb"

# Install authlogic a
load "authlogic.rb" if install_authlogic

# Create Facebook application
load "facebook.rb" if install_facebook

# Set up deployment scripts
load "deploy.rb"


# Finalize setup
rake "db:create"
rake "db:create", :env => "test"
rake "db:migrate"

run "echo 'TODO' > README"
run "rm public/index.html"


git :add => "."
git :commit => "-a -m 'Finishing application setup'"

