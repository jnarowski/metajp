module Metajp
  
  def self.include_super_controller
    ::Shared::SuperCrud::Controller
  end

  def self.include_super_helper
    ::Shared::SuperCrud::Controller
  end

  def self.include_super_model
    ::Shared::SuperCrud::Controller
  end
  
end