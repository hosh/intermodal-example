require 'spec_helper'

describe Account do
  context 'when validating' do
    it { should validate_presence_of :name }
  end

  context 'when associating' do
    it { should have_many :access_credentials }
  end
end
