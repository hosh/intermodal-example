require 'machinist/active_record'
require 'forgery'

module Machinist
  class Lathe
    include Intermodal::Let

    let(:sham_company_name) { Forgery(:name).company_name }
    let(:sham_name)         { Forgery(:lorem_ipsum).words(3) }
  end
end

# Blueprints
Account.blueprint do
  name { "#{sham_company_name} #{sn}" }
end

Thing.blueprint do
  name { "#{sham_name} #{sn}" }
end
