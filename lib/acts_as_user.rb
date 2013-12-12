require "acts_as_user/version"
require 'orm_adapter'

module ActsAsUser
  @@default_ignored_attributes = ["created_at", "updated_at", "id", "userable_type", "userable_id"]

  mattr_accessor :ignored_attributes
  @@ignored_attributes = @@ignored_attributes.to_a + @@default_ignored_attributes

  def self.setup
    yield self    
  end

  def self.devise?
    defined?(Devise).present?
  end
end

require 'acts_as_user/user_delegate'
require 'acts_as_user/is_user'
require 'acts_as_user/railtie'
