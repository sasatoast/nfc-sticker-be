module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      include RackSessionFix
      skip_before_action :authenticate_user!, only: [ :create ]
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        register_success && return if resource.persisted?

        register_failed
      end

      def register_success
        render json: { message: "Signed up successfully.", user: resource }, status: :ok
      end

      def register_failed
        render json: {
          message: "Signed up failure.",
          errors: resource.errors.full_messages
        }, status: :unprocessable_entity
      end

      def sign_up_params
         params.require(:user).permit(:email, :name, :password, :password_confirmation)
      end
    end
  end
end
