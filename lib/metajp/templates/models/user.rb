class User < ActiveRecord::Base
  acts_as_authentic
  
  #----------------------------------------------------------------
  # account general
  #----------------------------------------------------------------

  def generate_temporary_password!
    chars = ("a".."z").to_a + ("1".."9").to_a 
    temp_pass = Array.new(8, '').collect{chars[rand(chars.size)]}.join
    self.password = temp_pass                 
    self.password_confirmation = temp_pass
  end
  
  #----------------------------------------------------------------
  # account activation
  #----------------------------------------------------------------

  # now let's define a couple of methods in the user model. The first
  # will take care of setting any data that you want to happen at signup
  # (aka before activation)
  def signup!(params)
    self.login = params[:user][:login]
    self.email = params[:user][:email]
    generate_temporary_password!
    save_without_session_maintenance
  end
 
  # the second will take care of setting any data that you want to happen
  # at activation. at the very least this will be setting active to true
  # and setting a pass, openid, or both.
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    save
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end
 
  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end

  #----------------------------------------------------------------
  # password reset
  #----------------------------------------------------------------

  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end

end