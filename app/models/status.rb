class Status < ActiveRecord::Base
  attr_accessible :value, :foreground_color, :background_color
    
  has_many :events
  
  def value
    read_attribute(:value).capitalize
  end
  
  def self.colors
    File.read(Rails.root.join('app/assets/colors.txt')).split("\n")
  end
  
end