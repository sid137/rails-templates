# Rspec
# cucumber
# webrat
# factory-girl
# HAML
# compass-sass
# exception_notifier
# will_paginate

gem "rspec", :lib => false
gem "rspec-rails", :lib => false

gem "cucumber", :lib => false
gem "webrat", :lib => false

gem "thoughtbot-factory_girl", :lib => "factory_girl", :source => "http://gems.github.com"
run "mkdir -p spec/factories/"

gem "haml"
gem "chriseppstein-compass", :lib => false
run "mkdir public/stylesheets/sass"


rake "gems:install", :sudo => true

generate "rspec"
generate "cucumber"


# Webrat fix to print full stack trace
file "features/support/local_env.rb", <<-END
class Webrat::Session
  alias_method :old_formatted_error, :formatted_error
  def formatted_error

    def unescape( text )
      html = { '&amp;' => '&', '&gt;' => '>', '&lt;' => '<', '&quot;' => '"' }
      text.to_s.gsub(/(?:#{html.keys.join('|')})/) { |special| html[special] }
    end

    doc = Nokogiri::HTML( old_formatted_error )
    content = []
    doc.xpath('//body/p|//body/pre').each do |para|
      value = unescape( para.inner_html.gsub( /<\/?[^>]+>/, '') )
      content << value unless value =~ /^\s*(?:\{|RAILS_ROOT:|Parameters:|Show session dump|Headers:)/
    end

    content.join("\n");
  end
end
END


file "features/support/local_path.rb", <<-END
END


file "app/views/layouts/application.html.haml", <<-END
!!!
%html
  %head
    %title Website
  %body
    = render :partial => "layouts/user"
    = yield
END
