class Status < ActiveRecord::Base
  attr_accessible :value, :foreground_color, :background_color, :include_in_calc
  
  validates_presence_of :value, :foreground_color, :background_color
  
  after_save :reload_events
  # events.rb needs to be reloaded to generate
  # new class methods, or you'll get a method
  # missing error
  
  has_many :events, :dependent => :destroy
  
  def value=(string)
    write_attribute(:value, string).downcase
  end
  
  def self.colors
    File.read(Rails.root.join('app/assets/colors.txt')).split("\n")
  end
  
  def reload_events
    load 'event.rb'                  
  end
  
  def value_for_select
    value.capitalize
  end
  
end