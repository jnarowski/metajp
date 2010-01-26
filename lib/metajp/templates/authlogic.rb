require 'metajp'
@template ||= Metajp.get_template_path

if yes?("Do you want to add authlogic to this project?")
  gem 'authlogic'
  
  # user sessions
  generate(:session, "user_session")
  generate(:controller, "user_sessions")
  run "cp #{@template}/controllers/user_sessions_controller.rb app/controllers/user_sessions_controller.rb"

  # create the model
  generate(:model, "user", "first_name:string", "last_name:string", "email:string", "crypted_password:string", "password_salt:string", "persistence_token:string", "perishable_token:string")  
  run "cp #{@template}/models/user.rb app/models/user.rb"
  
  # user_session routes
  route "map.login 'login', :controller => 'user_sessions', :action => 'new'"
  route "map.login 'logout', :controller => 'user_sessions', :action => 'destroy'" 
  route "map.resources :user_sessions"
  route "map.resources :users"
  
  if yes?("Do you want to add user activation and password reset?")

    # account routes
    route "map.login '/login', :controller => :user_sessions, :action => :new"
    route "map.logout '/logout', :controller => :user_sessions, :action => :destroy"
    route "map.account '/account', :controller => :users, :action => :show"
    route "map.edit_account '/account/edit', :controller => :users, :action => :edit"

    route "map.resources :password_resets, :path_prefix => 'account', :controller => 'account/password_resets'"

    # account activation
    route "map.register '/register/:perishable_token', :controller => 'account/activations', :action => 'new'"
    route "map.activate '/activate/:id', :controller => 'account/activations', :action => 'create'"
    route "map.signup '/signup', :controller => 'users', :action => 'new'"

    # account password reset
    route "map.forgot_password '/account/forgot-password', :controller => 'account/password_resets', :action => 'new'"
    route "map.change_password '/account/change-password/:perishable_token', :controller => 'account/password_resets', :action => 'edit'"
    route "map.reset_password '/account/reset-password/:perishable_token', :controller => 'account/password_resets', :action => 'update'"
  end
  
  rake "db:migrate"
end

# gem 'authlogic'
# rake 'gems:install', :sudo => true
# 
# # MVC for user
# 
# generate(:model, "user", "email:string", "crypted_password:string", "password_salt:string", "persistence_token:string")
# 
# file "app/models/user.rb", <<-END
# class User < ActiveRecord::Base
# acts_as_authentic
# end
# END
# 
# run "cp #{@template}/users_controller.rb app/controllers/users_controller.rb"
# run "cp #{@template}/application_controller.rb app/controllers/application_controller.rb"
# 
# file "app/views/users/index.haml", <<-END
# %h2 User List
# %ul
# - @users.each do |u|
# %li= u.email
# END
# 
# file "app/views/users/edit.haml", <<-END
# %h2 Edit Profile
# = render :partial => 'form'
# END
# 
# file "app/views/users/new.haml", <<-END
# %h2 New Profile
# = render :partial => 'form'
# END
# 
# file "app/views/users/_form.haml", <<-END
# - form_for @user do |f|
# = f.error_messages
# %p
# = f.label :email
# %br
# = f.text_field :email
# %p
# = f.label :password
# %br
# = f.password_field :password
# %p
# = f.label :password_confirmation
# %br
# = f.password_field :password_confirmation
# %p
# = f.submit "Submit"
# END
# 
# # MVC for user_session
# 
# generate(:session, "user_session")
# generate(:controller, "user_sessions")
# run "cp #{@template}/user_sessions_controller.rb app/controllers/user_sessions_controller.rb"
# 
# file "app/views/user_sessions/new.haml", <<-END
# %h2 Login
# - form_for @user_session do |f|
# = f.error_messages
# %p
# = f.label :email
# %br
# = f.text_field :email
# %p
# = f.label :password
# %br
# = f.password_field :password
# %p
# = f.submit "Submit"
# END
# 
# # add routes
# 
# file "config/routes.rb", <<-END
# ActionController::Routing::Routes.draw do |map|
# map.login "login", :controller => "user_sessions", :action => "new"
# map.logout "logout", :controller => "user_sessions", :action => "destroy"
# 
# map.resources :user_sessions
# map.resources :users
# 
# map.root :users
# 
# map.connect ':controller/:action/:id'
# map.connect ':controller/:action/:id.:format'
# end
# END
# 
# # run migrations
# 
# 