require 'spec_helper'

describe Thing do
  context 'when validating' do
    it { should validate_presence_of :name }
  end
end
