require 'spec_helper'

describe AccessToken do
  include SpecHelpers::Application

  describe '.authenticate!' do
    subject { AccessToken.authenticate!(access_token.token) }

    it 'should accept a token as a parameter' do
      should_not be_nil
    end

    it 'should return an Account associated with the token' do
      subject.id.should eql(access_token.account_id)
    end
  end

  describe '.generate!' do
    subject { AccessToken.generate!(account) }
    let(:number_of_tokens_before_generate) { AccessToken.count }

    it 'should generate and return an unique token' do
      number_of_tokens_before_generate.should_not be_nil
      subject.should_not be_nil
      AccessToken.count.should be(number_of_tokens_before_generate + 1)
    end

    it 'should associate the token with the account' do
      AccessToken.authenticate!(subject).should eql(account)
    end
  end
end
