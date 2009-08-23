gem "facebooker"

name = "horse"
data = ERB.new(File.read('facebook/facebooker.yml.erb')).result

file "config/facebooker.yml", data
