class API::V1::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token


def create
  @user = User.create(user_params)

  if @user.save
    render json: {user: @user}, status: 200
  else
    render json: {error: "can't registered"}, status: 500

  end

  def show
    @user = User.find(params[:id])
  end

end
  private
def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end
  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end
  end
