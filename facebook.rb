gem "facebooker"

file "config/facebooker.yml", <<-EOF
# File: config/facebooker-mock.yml
# The api key, secret key, and canvas page name are required to get started
# Tunnel configuration is only needed if you are going to use the facebooker:tunnel Rake tasks
# Your callback url in Facebook should be set to http://public_host:public_port
# If you're building a Facebook connect site, 
#    change the value of set_asset_host_to_callback_url to false
# To develop for the new profile design, add the following key..
# api: new
# remove the key or set it to anything else to use the old facebook design.
# This should only be necessary until the final version of the new profile is released.
 
development:
 api: new
 api_key: 0cfe215a4e68d625812598396ac39161
 secret_key: b5df064e2b474361b48db9f043bf32e3
 canvas_page_name: sidtest1
 callback_url: http://sid137.dyndns.org:3000
 pretty_errors: true
 set_asset_host_to_callback_url: true
 tunnel:
     public_host_username: fooberryfoo
     public_host: staging.travelerstable.com
     public_port: 8888
     local_port: 3000
     server_alive_interval: 0
test:
  api: new
  api_key:
  secret_key:
  canvas_page_name:
  pretty_errors: true
  set_asset_host_to_callback_url: true
  tunnel:
    public_host_username:
    public_host:
    public_port: 4007
    local_port: 3000
    server_alive_interval: 0
production:
  api: new
  api_key:
  secret_key:
  canvas_page_name:
  pretty_errors: true
  set_asset_host_to_callback_url: true
  tunnel:
    public_host_username:
    public_host:
    public_port: 4007
    local_port: 3000
    server_alive_interval: 0
EOF
