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
  end
