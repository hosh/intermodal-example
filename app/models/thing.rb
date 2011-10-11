class Thing < ActiveRecord::Base
  # Validations
  validates_presence_of :name
end
