class Status < ActiveRecord::Base
  attr_accessible :value, :foreground_color, :background_color
  
  after_save :reload_events
    
  has_many :events
  
  def value
    read_attribute(:value).capitalize
  end
  
  def self.colors
    File.read(Rails.root.join('app/assets/colors.txt')).split("\n")
  end
  
  def reload_events
    load 'event.rb'
  end
  
end