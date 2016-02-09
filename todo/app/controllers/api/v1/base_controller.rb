module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session

      private

      def current_user
        if doorkeeper_token
          @current_user ||= User.find doorkeeper_token.resource_owner_id
        end
      end
    end
  end
end
