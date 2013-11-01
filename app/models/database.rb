class Database < ActiveRecord::Base
  attr_accessible :name, :database_server_id, :site_ids
  
  belongs_to :database_server
  
  has_many :site_databases, :dependent => :destroy
  has_many :sites, :through => :site_databases
  
end