require "acts_as_user/version"
require 'orm_adapter'

module ActsAsUser
  extend ActiveSupport::Autoload

  #Eager loads the modules
  eager_autoload do
    autoload :UserDelegate
    autoload :IsUser
  end

  # ActiveSupport::Autoload automatically defines
  # an eager_load! method. In this case, we are
  # extending the method to also eager load the
  # ActsAsUser modules.
  def self.eager_load!
    super 
    ActsAsUser::UserDelegate.eager_load!
    ActsAsUser::IsUser.eager_load!
  end

  #We ignore some attribues that might cause a collision between models
  @@default_ignored_attributes = ["created_at", "updated_at", "id", "userable_type", "userable_id"]

  #Array to define the models that are inhering from the user
  @@models_acting_like_users = []
  mattr_reader :models_acting_like_users

  #We append the extra attributes you want to ignore to the default ones
  mattr_accessor :ignored_attributes
  @@ignored_attributes = @@ignored_attributes.to_a + @@default_ignored_attributes

  mattr_accessor :models_acting_as_users
  @@models_acting_as_users = []

  def self.setup
    yield self    
  end

  #Checking if devise is present
  def self.devise?
    defined?(Devise).present?
  end

  #We add some virtual attributes that dont't play well when devise is present
  def self.add_devise_attributes_to_ignore
    if self.devise?
      devise_ignore_attrs = ['password', 'password_confirmation', 'encrypted_password']
      self.ignored_attributes << devise_ignore_attrs
      self.ignored_attributes.flatten!
    end
  end
end

require 'acts_as_user/railtie'
