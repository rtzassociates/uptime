class Status < ActiveRecord::Base
  attr_accessible :value, :text_color, :include_in_calc
  
  validates_presence_of :value, :text_color
  
  has_many :events, :dependent => :destroy
  
  def value=(string)
    write_attribute(:value, string).downcase
  end
  
  def self.colors
    File.read(Rails.root.join('app/assets/colors.txt')).split("\n")
  end
  
  def value_for_select
    value.capitalize
  end
  
end
