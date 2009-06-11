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
file "features/support/local_env.rb",<<-END
class Webrat::Session
  alias_method :old_formatted_error, :formatted_error
  def formatted_error

    def unescape( text )
      html = { '&amp;' => '&', '&gt;' => '>', '&lt;' => '<', '&quot;' => '"' }
      text.to_s.gsub(/(?:\#{html.keys.join('|')})/) { |special| html[special] }
    end

    doc = Nokogiri::HTML( old_formatted_error )
    content = []
    doc.xpath('//body/p|//body/pre').each do |para|
      value = unescape( para.inner_html.gsub( /<\\/?[^>]+>/, '') )
      content << value unless value =~ /^\\s*(?:\\{|RAILS_ROOT:|Parameters:|Show session dump|Headers:)/
    end

    content.join("\\n");
  end
end
END


file "features/support/paths.rb", <<-END
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /(a|an|the)?\\s*home\\s*page/
      '/'
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"\#{page_name}\" to a path.\\n" +
        "Now, go and add a mapping in \#{__FILE__}"
    end
  end
end

World(NavigationHelpers)

END

file "app/views/layouts/application.html.haml", <<-END
!!!
%html
  %head
    %title Website
  %body
    = yield
END
