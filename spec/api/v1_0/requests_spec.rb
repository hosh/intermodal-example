require 'spec_helper'

describe V1_0 do
  include Intermodal::RSpec::Resources
  include SpecHelpers::APIRequests::V1_0
  let(:request_url_prefix) { 'v1.0' }

  context 'Resources' do

    let(:model_factory_options) { (model_parent ? { parent_names.last.to_s.singularize => model_parent } : {:account => account} ) }
    let(:model_collection) do
      3.times { model.make!(model_factory_options) }
      (model_parent ? model.by_parent(model_parent) : model.by_account(account) )
    end

    resources :things do
      given_create_attributes :name => 'New Thing', :account_id => 1
      given_update_attributes :name => 'Updated Thing'

      expects_resource_crud
    end
  end
end
