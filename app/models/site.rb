class Site < ActiveRecord::Base
  attr_accessible :name, :user_ids, :application_server_ids, :database_ids, :description, :urls_attributes, :site_environment_id
  
  has_many :event_sites, :dependent => :destroy
  has_many :events, :through => :event_sites, :dependent => :destroy
  
  has_many :site_application_servers, :dependent => :destroy
  has_many :application_servers, :through => :site_application_servers
  
  has_many :site_databases, :dependent => :destroy
  has_many :databases, :through => :site_databases
  
  has_many :subscriptions, :dependent => :destroy
  has_many :users, through: :subscriptions, :dependent => :destroy
  
  has_many :urls, :dependent => :destroy
  accepts_nested_attributes_for :urls, allow_destroy: true
  
  validates :name, :presence => true, :uniqueness => true
  
  before_save :touch_application_servers
  
  belongs_to :site_environment

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      order("name ASC")
    end
  end

  def total_downtime
    totals = Status.where(:include_in_calc => true).each_with_object([]) do |status, arr|
      arr << events.where(:status_id => status.id).map { |e| e.duration }.sum
    end
    totals.sum

    #totals = Status.all.each_with_object([]) do |status, array|
    #  if status.include_in_calc
    #    array << events.send("#{status.value.downcase}").map { |e| e.duration }.sum
    #  end
    #end
    #totals.sum
  end
  
  def lifespan_in_seconds
    Time.zone.now.to_i - created_at.to_i
  end
  
  def uptime_in_seconds
    lifespan_in_seconds - total_downtime
  end
  
  def uptime
    (( uptime_in_seconds.to_f / lifespan_in_seconds.to_f ) * 100).round(2)
  end
  
  def status
    events.unresolved.empty? ? "OK" : events.unresolved.last.status.value
  end
  
  def self.with_urls
    Site.joins(:urls)
  end
  
  private
  
  def touch_application_servers
    application_servers.each do |application_server|
      application_server.touch
    end
  end
  
end
