module SpecHelpers
  module APIRequests
    extend ActiveSupport::Concern

    module V1_0
      extend ActiveSupport::Concern

      included do
        include SpecHelpers::APIRequests
        let(:request_url_prefix) { 'v1.0' }
        let(:api) { ::V1_0 }
      end
    end

    included do
      include Intermodal::RSpec::Rack
      include SpecHelpers::Application

      let(:application) { IntermodalExample::Application }
      let(:request_url_prefix) { '' }

      let(:format) { :json }
      let(:presenter_scope) { nil }
      let(:presented_resource) { json_parser.parse(resource.as_json(:api => api, :scope => presenter_scope).to_json) }
      let(:http_headers) { { 'X-Auth-Token' => access_token.token, 'Accept' => 'application/json'  } }
    end

    module ClassMethods
      def expects_unauthorized_access_to_respond_with_401
        context 'With unauthorized access credentials' do
          let(:http_headers) { { 'X-Auth-Token' => '', 'Accept' => 'application/json' } }

          expects_status(401)
        end
      end

      def expects_json_presentation(_presenter_scope = nil)
        let(:presenter_scope) { _presenter_scope } if _presenter_scope

        it 'should present a JSON object' do
          body.should eql(presented_resource)
        end
      end

      def expects_distance
        it 'should expose distance' do
          body[collection_name.to_s].each do |resource|
            resource['distance'].should_not be_blank
          end
        end

        it 'should expose a floating-point distance' do
          body[collection_name.to_s].each do |resource|
            resource['distance'].should be_kind_of(Float)
          end
        end
      end

      def expects_pagination(options = {})
        # Default behavior for will_paginate
        options[:page] ||= 1
        options[:collection_name] ||= 'collection'

        context 'when paginating' do
          let(:expected_total_pages) { collection.size/SITE_PER_PAGE + 1 }

          if options[:empty_collection]
            it 'should have an empty collection' do
              body[options[:collection_name].to_s].should be_empty
            end
          else
            it 'should have a collection' do
              body[options[:collection_name].to_s].should_not be_empty
            end
          end

          it "should be on page #{options[:page]}" do
            body['page'].should eql(options[:page])
          end

          it 'should have total_pages' do
            body['total_pages'].should eql(expected_total_pages)
          end

          it 'should have total_entries' do
            body['total_entries'].should eql(collection.size)
          end
        end
      end
    end
  end
end
