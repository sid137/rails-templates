# Rspec
# HAML
# exception_notifier
# will_paginate
# cucumber
# factory_girl


gem "rspec", :init => false
gem "rspec-rails", :init => false

gem "thoughtbot-factory_girl", :lib => "factory_girl", :source => "http://gems.github.com"
run "mkdir -p spec/factories/"

gem "haml"
run "mkdir public/stylesheets/sass"


rake "gems:install", :sudo => true
generate "rspec"
