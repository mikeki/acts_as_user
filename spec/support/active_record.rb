require 'active_record'


#ActiveRecord::Migrator.up "db/migrate"

load File.dirname(__FILE__) + '/schema.rb'
load File.dirname(__FILE__) + '/models.rb'
