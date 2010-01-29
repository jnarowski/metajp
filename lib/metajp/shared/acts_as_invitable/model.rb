module Metajp
  
  #----------------------------------------------------------------
  # This module allows you to add invite codes to your application
  # It extends your model with the invitation class and instance level variables
  # 
  # Usage:
  #
  #  require 'metajp'
  #  class Invitation
  #    acts_as_invitable
  #  end
  #----------------------------------------------------------------

  module ActsAsInvitable
    
    def self.included(base)
      base.extend ClassMethods  
    end
    
    module ClassMethods
      def acts_as_invitable   
        validates_uniqueness_of :code
        validates_presence_of :code
        belongs_to :user
        named_scope :search, lambda { |search| { :conditions => ['code like ? OR sent_to like ?', "%#{search}%", "%#{search}%"] } }
        include Metajp::ActsAsInvitable::InstanceMethods
        extend Metajp::ActsAsInvitable::SingletonMethods
      end
    end
    
    # This module contains class methods
    module SingletonMethods
      def find_valid(code)
        find(:first, :conditions => ["code = ? AND quantity > 0", code])
      end
    end
        
    module InstanceMethods
      def redeem!
        self.quantity -= 1
        self.save
      end
  
      def before_validation 
        self.generate_unique_code if self.code.blank?
      end

      # Generates an alphanumeric code using an MD5 hash
      # * +code_length+ - number of characters to return
      def generate_code(code_length=6)
        chars = ("a".."z").to_a + ("1".."9").to_a
        new_code = Array.new(code_length, '').collect{chars[rand(chars.size)]}.join
        Digest::MD5.hexdigest(new_code)[0..(code_length-1)].upcase
      end

      # Generates unique code based on +generate_code+ method
      def generate_unique_code
        begin
          self.code = generate_code(10)
        end until !self.active_code?
      end
      
      # makes sure the code is unique
      def active_code?
        Invitation.first(:conditions => { :code => self.code })
      end
    end
  end
end