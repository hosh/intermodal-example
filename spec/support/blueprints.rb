require 'machinist/active_record'
require 'forgery'

SHAM = {
  name:          ->{ Forgery(:lorem_ipsum).words(3) },
  company_name:  ->{ Forgery(:name).company_name }
}

# Blueprints
Account.blueprint do
  name { SHAM[:company_name].() }
end

Thing.blueprint do
  name { SHAM[:name].() }
end
