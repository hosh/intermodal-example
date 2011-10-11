require 'spec_helper'

describe AccessCredential do
  context 'when validating' do
    subject { other_access_credential; access_credential }
    let(:access_credential) { AccessCredential.create(:identity => SecureRandom.hex(10), :account => account) }
    let(:other_access_credential) { AccessCredential.create(:identity => SecureRandom.hex(10), :account => account) }
    let(:account) { Account.create(:name => SecureRandom.hex(32)) }

    it { should validate_uniqueness_of :identity }
  end

  context 'when associating' do
    it { should belong_to :account }
  end
end
