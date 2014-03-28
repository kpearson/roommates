class UsersController < ApplicationController
	# before_filter :require_login

	def index
		redirect_to "/"
	end

	def show
		@current_user = current_user
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to "/users/#{@user.id}"
		else 
			render "new"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
	end

	private

	def user_params
		params.require(:user).permit(:name, :phone_number, :email, :password, :password_confirmation)
	end

	def require_login
		unless logged_in?
			flash[:error] = "You must be logged in to access this section"
			redirect_to new_session_path
		end
	end
end
