module SpecHelpers
  module Application
    extend ActiveSupport::Concern

    included do
      # Default API
      let(:api) { ::V1_0 }

      # Resource
      let(:account) { Account.make! }
      let(:different_account) { Account.make! }

      let(:access_token) { AccessToken.generate!(account) }

      let(:thing) { Thing.make!(:account => account) }
    end
  end
end
