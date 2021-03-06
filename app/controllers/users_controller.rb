class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update]
	def index
		@users = User.paginate(page: params[:page], per_page: 3)
	end
	def new
		@user = User.new
	end
	def show
		#@user = User.find(params[:id])
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
	end
	def create

		@user = User.new(user_params)
		if(@user.save)
			session[:user_id] = @user.id

			flash[:success] = "Welcome to the alpha blog #{@user.user_name}"
			redirect_to user_path(@user)

		else
			render :new
		end
	end
	def edit
		#@user = User.find(params[:id]) You can delete this line since you have setUser method before action
	end
	def update
		#@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:success] = "Account updated successfully"
			redirect_to articles_path
		else
			render :edit
		end
	end


	private
		def user_params
			params.require(:user).permit(:user_name, :email, :password)
		end

		def set_user
			@user = User.find(params[:id])
		end
		def require_same_user
			if current_user != @user
				flash[:danger] = "You can only edit your own account"
				redirect_to root_path
			end
		end
end