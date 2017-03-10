class Users::SessionsController < Devise::SessionsController

  
  skip_before_action :verify_signed_out_user
  
  def create
    user = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(user, request)
    render json: { authentication_token: token,
    user: user}
  end

  def destroy
    if current_user && Tiddle.expire_token(current_user, request)
      head :ok
    else
      # Client tried to expire an invalid token
      render json: { error: 'invalid token' }, status: 401
    end
  end


  private

    # this is invoked before destroy and we have to override it
    def verify_signed_out_user
    end
end