gem "authlogic"
gem "bcrypt-ruby", :lib => "bcrypt"

rake "gems:install", :sudo => true

generate :session, "user_session"
generate :rspec_controller, "user_sessions"
generate :rspec_controller, "users"

# Done manually t onot have duplicate migrations
# generate :rspec_model, "user"

# Routes
route "map.resource :user_sessions" 
route "map.resource :account, :controller => 'users'"
route "map.resources :users"
route "map.root :controller => 'user_sessions', :action => 'new' # optional, this just sets the root route"

run "mkdir -p features/user_registration/"

file "features/user_registration/user_registration.feature", <<-END
Feature: User Registration
    In order to create a personalized user space
    As a guest to the site
    I want to be able to register an account

    Scenario: Creating a new account
       Given I am on the home page
       And I am not logged in
       When I follow "Register"
       Then I should see thank you for registering
END

file "features/user_registration/user_registration_steps.rb", <<-END
Given /^I am not logged in$/ do
end

Then /^I should see thank you for registering$/ do
    pending
end
END

# User model migration
file "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_users.rb"  , <<-END 
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login,               :null => false                # optional, you can use email instead, or both
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => false                # optional, see below
      t.string    :password_salt,       :null => false                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
     
      t.timestamps
    end
    
    add_index :users, :email
    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :perishable_token    
    add_index :users, :last_request_at

  end

  def self.down
    drop_table :users
  end
end
END


# User Model
file "app/models/user.rb", <<-END
class User < ActiveRecord::Base
  acts_as_authentic do |c|
    # c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end # block optional
end
END

# User Controller
file "app/controllers/users_controller.rb", <<-END
class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
 
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
 
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
 
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
END


# User Sessions Controller
file "app/controllers/user_sessions_controller.rb", <<-END
class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
 
  def new
    @user_session = UserSession.new
  end
 
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
 
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
END

file "app/controllers/application_controller.rb", <<-END
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
 
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
   
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
   
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_sessions_url
        return false
      end
    end
 
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
   
    def store_location
      session[:return_to] = request.request_uri
    end
   
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
END

# User views
file "app/views/users/new.html.haml", <<-END
%h1 Register Account

- form_for @user, :url => account_path do |f|
  = f.error_messages
  = render "form", :object => f
  = f.submit "Register" 
END


file "app/views/users/edit.html.haml", <<-END
%h1 Edit My Account

- form_for @user, :url => account_path do |f|
  = f.error_messages
  = render "form", :object => f
  = f.submit "Update"

%br
= link_to "My Profile", account_path
END

file "app/views/users/show.html.haml", <<-END
%p
  %b Login:
  %=h @user.login
%p
  %b Login count:
  %=h @user.login_count
%p
  %b Last Request at:
  %=h @user.last_request_at
%p
  %b Last login at:
  %=h @user.last_login_at
%p
  %b Current login at:
  %=h @user.current_login_at
%p
  %b Last login IP
  %=h @user.last_login_ip

%= link_to 'Edit', edit_account_path
END

file "app/views/users/_form.html.haml", <<-END
= form.label :login
%br
= form.text_field :login
%br
%br
= form.label :password, form.object.new_record? ? nil : "Change password"
%br
= form.password_field :password
%br
%br
= form.label :password_confirmation
%br
= form.password_field :password_confirmation
%br
END

# User Session Views
#login
file "app/views/user_sessions/new.html.haml", <<-END
%h1 Login
 
- form_for @user_session, :url => user_sessions_path do |f| 
  = f.error_messages 
  = f.label :login 
  %br 
  = f.text_field :login 
  %br
  %br 
  = f.label :password 
  %br
  = f.password_field :password 
  %br
  %br
  = f.check_box :remember_me 
  = f.label :remember_me 
  %br
  %br 
  = f.submit "Login" 
END

# Factory
file "spec/factories/user.rb", <<-END
Factory.define :user do |u|
  u.login 'johndoe'
  u.email 'john@doe.com'
end
END

# Specs
file "spec/models/user_spec.rb", <<-END
END


# Admin pages
