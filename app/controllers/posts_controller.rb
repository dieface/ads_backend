class PostsController < ApplicationController

	def all
		@posts = Post.all.order(created_at: :desc)
	end

	def index
		@posts = Post.all.order(created_at: :desc)
	end

	def new
		@post = Post.new
	end

	def create

		genre = params[:genre] || params[:post][:genre]

		# Official Post (from web browser)
		if genre == 'official'

			# Create post
			@post = current_user.posts.build(post_params)
			@post.end_date = DateTime.new(@post.end_date.year, @post.end_date.month, @post.end_date.day, 23, 59, 59, 0)

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
			write_json
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
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :back	
	end

	def write_json
	  posts_json = []
	  
	  puts "**** in write_json"
	  

	  Post.all.order(created_at: :desc).each do |post|
	  	puts "post.user_id = " + post.user_id.to_s
	  	user = User.find(post.user_id)

	    post_json = {

	    	# Post
				"id"         => post.id,
				"genre"      => get_str(post.genre),
				"content"    => get_str(post.content),
				"lat"        => get_str(post.lat),
				"lng"        => get_str(post.lng),
				"address"    => get_str(post.address),
				"start_date" => get_iso8601(post.start_date),
				"end_date"   => get_iso8601(post.end_date),
				"created_at" => get_iso8601(post.created_at),
				"updated_at" => get_iso8601(post.updated_at),
				"user_id"    => get_str(post.user_id),
				"aasm_state" => get_str(post.aasm_state),

				# User
				"name"			 => get_str(user.name),
				"profile_photo_url"			 => get_str(user.profile_photo),

				# Custom for mobile app
				# "distance"	 => '',
				# "time_interval" => ''
	    } 
	    posts_json << post_json
	  end

	  File.open("public/posts.json","wb") do |f|
	    f.write(posts_json.to_json)
	  end 		
	end

	private

	def get_str(str)
		if str
			str.to_s
		else
			''
		end
		# str.nil ? "" : str.to_s
	end

	def get_iso8601(date)
		if date
			date.iso8601
		else
			''
		end
	end

  def post_params
		# params.require(:post).permit(:genre, :content, :lat, :lng, :address, :start_date, :end_date)
		params.require(:post).permit(:genre, :content, :start_date, :end_date)

  end	
end