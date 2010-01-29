require 'rubygems'
# super_crud
require File.dirname(__FILE__) + '/metajp/shared/super_crud/controller.rb'
require File.dirname(__FILE__) + '/metajp/shared/super_crud/model.rb'
require File.dirname(__FILE__) + '/metajp/shared/super_crud/helper.rb'

# acts_as_invitable
require File.dirname(__FILE__) + '/metajp/shared/acts_as_invitable/model.rb'

module Metajp
  
  VERSION = '0.1.0'
  
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
  
  def self.get_template_path
    Gem.path.each do |path|
      tmp_path = "#{path}/gems/metajp-#{VERSION}" 
      return "#{tmp_path}/lib/metajp/templates" if File.exists?(tmp_path) 
    end
    raise "Cannot find gem 'metajp-#{VERSION}' on your system" unless @template
  end
    
end

if defined?(Rails) && defined?(ActionController)
  ActionController::Base.send :include, Metajp::Controller
  ActiveRecord::Base.send(:include, Metajp::ActsAsInvitable)
end


