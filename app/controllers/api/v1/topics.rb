module API
  module V1
    class Topics < Grape::API
      include API::V1::Defaults
      resources :topics do
        desc "get all topic"
        get do
          Topic.all
        end

        desc 'find by id'
        get ':id' do
          Topic.find params[:id]
        end
      end
    end
  end
end