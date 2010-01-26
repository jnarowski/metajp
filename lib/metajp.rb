require File.dirname(__FILE__) + '/metajp/shared/super_crud/controller.rb'
require File.dirname(__FILE__) + '/metajp/shared/super_crud/model.rb'
require File.dirname(__FILE__) + '/metajp/shared/super_crud/helper.rb'

module Metajp
  
  #----------------------------------------------------------------
  # extensions for the controller
  #----------------------------------------------------------------

  module Controller    
    def self.included(base)  
      base.send :extend, ClassMethods 
    end  
  
    module ClassMethods
      def super_controller 
        send :include, Metajp::Shared::SuperCrud::Controller 
      end
    end
  end
    
end

ActionController::Base.send :include, Metajp::Controller