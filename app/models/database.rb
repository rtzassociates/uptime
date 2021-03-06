class Database < ActiveRecord::Base
  attr_accessible :name, :database_server_id, :site_ids
  
  belongs_to :database_server, touch: true
  
  has_many :site_databases, :dependent => :destroy
  has_many :sites, :through => :site_databases
  
  validates :name, :presence => true, :uniqueness => true
  validates :database_server_id, :presence => true
  
  def self.search(search)
    if search
      joins(:database_server).where('databases.name LIKE ? OR servers.name LIKE ?', "%#{search}%", "%#{search}%")
    else
      order("name ASC")
    end
  end
  
end
