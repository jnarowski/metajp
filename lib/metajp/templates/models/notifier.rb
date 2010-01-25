class Notifier < ActionMailer::Base
  default_url_options[:host] = 'localhost:3000'
  
  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "petit vogue <user-activation@petitvogue.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end
 
  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "petit vogue <user-activation@petitvogue.com>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end

  def password_reset_instructions(user)  
    subject       "Password Reset Instructions"  
    from          "petit vogue <noreply@petitvogue.com>"
    recipients    user.email  
    sent_on       Time.now  
    body          :reset_password_url => change_password_url(user.perishable_token)
  end
  
end