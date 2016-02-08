module Api
  module V1
    class UsersController < BaseController
      # protect_from_forgery with: :null_session
      before_filter :allow_cors
      skip_before_filter :verify_authenticity_token

      # For all responses in this controller, return the CORS access control headers.

      def allow_cors
        headers["Access-Control-Allow-Origin"] = "*"
        headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
        headers["Access-Control-Allow-Headers"] =
          %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token X-AuthToken X-Identity Authorization}.join(",")

        render text: '' if request.request_method == "OPTIONS"
      end

      doorkeeper_for :all
      respond_to :json

      def show
        respond_with current_user.as_json(except: :password_digest)
      end
    end
  end
end
