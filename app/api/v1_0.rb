class V1_0 < Rails::Engine
  include Intermodal::API

  map_data do
    presentation_for :thing do
      presents :id
      presents :name
      presents :description
      presents :created_at
      presents :updated_at
    end

    acceptance_for :thing do
      accepts :name
      accepts :description
    end

    controllers do
      resources :things
    end

    routes.append do
      resources :things
    end
  end
end
