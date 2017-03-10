module Api
  module V1
    class Users::SessionsController < Devise::SessionsController
      skip_before_action :verify_signed_out_user

      def create
        user = warden.authenticate!(:scope => :user)
        token = Tiddle.create_and_return_token(user, request)
        render json: { authentication_token: token, user: user }
      end

      def destroy
        Tiddle.expire_token(current_user, request) if current_user
        render json: {loged_out: "loged_out"}
      end

    end
  end
end