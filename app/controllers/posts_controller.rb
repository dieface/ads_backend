class PostsController < ApplicationController

	def index
		Post.all
	end

	def new
		@post = Post.new
	end

	def create

		genre = params[:genre]

		# Official Post (from web browser)
		if genre == 'official'

			# Create post
			@user = current_user
			@post = @user.posts.build(post_params)

		#	Normal Post (from mobile app)
		elsif genre == 'normal'

			# Check user exists in db, if not create a guest user
			@user = User.find_by email: params[:email]
			unless @user
				@user = User.new(:name => params[:name], :email => params[:email], :guest => 1, :fb_data => params[:fb_data], :profile_photo => params[:profile_photo])
				@user.save!(:validate => false)
			end

			# Create post
			@post = Post.new(:genre => params[:genre], :content => params[:content], :lat => params[:lat], :lng => params[:lng], :address => params[:address])
			@post.author = @user
		end
		
		if @post.save
			write_json(@user)
			redirect_to posts_path
		else
			render :new
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def write_json(user)
	  posts_json = []

	  Post.all.each do |post|
	    post_json = {

	    	# Post
				"id"         => post.id,
				"genre"      => post.genre,
				"content"    => post.content,
				"lat"        => post.lat,
				"lng"        => post.lng,
				"address"    => post.address,
				"start_date" => post.start_date,
				"end_date"   => post.end_date,
				"created_at" => post.created_at,
				"updated_at" => post.updated_at,
				"user_id"    => post.user_id,
				"aasm_state" => post.aasm_state,

				# User
				"name"			 => user.name,
				"profile_photo_url"			 => user.profile_photo
	    } 
	    posts_json << post_json
	  end

	  File.open("public/posts.json","wb") do |f|
	    f.write(posts_json.to_json)
	  end 		
	end

	private

  def post_params
		# params.require(:post).permit(:genre, :content, :lat, :lng, :address, :start_date, :end_date)
		params.require(:post).permit(:genre, :content, :start_date, :end_date)

  end	
end