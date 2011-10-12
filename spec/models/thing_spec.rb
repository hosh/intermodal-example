require 'spec_helper'

describe Thing do
  include Intermodal::RSpec::Accountability
  include SpecHelpers::Application

  subject { thing }

  it { should be_valid }
  concerned_with_accountability

  context 'when validating' do
    it { should validate_presence_of :name }
  end
end
