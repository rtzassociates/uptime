class Status < ActiveRecord::Base
  attr_accessible :value, :foreground_color, :background_color, :include_in_calc
  
  after_save :reload_events
    
  has_many :events, :dependent => :destroy
  
  def value=(string)
    write_attribute(:value, string).downcase
  end
  
  def self.colors
    File.read(Rails.root.join('app/assets/colors.txt')).split("\n")
  end
  
  def reload_events
    load 'event.rb' # events.rb need to be reloaded to generate
                    # new class methods, or you'll get a method
                    # missing error
  end
  
  def value_for_select
    value.capitalize
  end
  
end