class Url < ActiveRecord::Base
  attr_accessible :name, :check_string
  
  belongs_to :site, touch: true
  
  validates :name, :presence => true, :uniqueness => true
  validates_format_of :name, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
end
