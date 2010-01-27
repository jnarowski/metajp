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
  
  rake "db:migrate" unless @base

end