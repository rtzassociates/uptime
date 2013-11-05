class Url < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :site, touch: true
  
  validates_format_of :name, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
end
