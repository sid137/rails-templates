# Rspec
# HAML
# exception_notifier
# will_paginate
# cucumber
# factory_girl


gem "rspec", :lib => false
gem "rspec-rails", :lib => false

gem "cucumberi", :lib => false
gem "webrat", :lib => false

gem "thoughtbot-factory_girl", :lib => "factory_girl", :source => "http://gems.github.com"
run "mkdir -p spec/factories/"

gem "haml"
run "mkdir public/stylesheets/sass"


rake "gems:install", :sudo => true

generate "rspec"
generate "cucumber"
