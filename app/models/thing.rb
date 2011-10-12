class Thing < ActiveRecord::Base
  include Intermodal::Models::Accountability

  # Validations
  validates_presence_of :name
end
