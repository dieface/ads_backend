class PostsController < ApplicationController

	def index
		Post.all
	end

	def new
		@post = Post.new
	end

	def create
		# email = params[:email]

		# # Normal Post
		# unless email.blank?
		# 	# Check user exists in db, if not create user
		# 	if (User.find_by email: email).blank?
		# 		@user = params[:user] ? User.new(params[:user]) : User.new_guest
		# 		@user.save
		# 	end

		# 	# Create post
		# 	@post = Post.new(post_params)
		# 	@post.author = @user

		# # Official Post
		# else
		# 	@post = current_user.posts.build(post_params)
		# end
		puts params[:type]
		puts params[:content]
		@post = Post.new(:type => params[:type], :content => params[:content])
		if @post.save
			redirect_to ads_path
		else
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def write_json
	end

	private

  def post_params
		params.require(:post).permit(:type, :content, :lat, :lng, :address, :start_date, :end_date)
  end	
end