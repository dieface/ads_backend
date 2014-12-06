class PostsController < ApplicationController

	def index
		Post.all
	end

	def new
	end

	def create
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
		params.require(:ad).permit(:scale, :start_date, :end_date, :lat, :lng, :url, :title, :description, :photos_attributes => [:image])
		# params.require(:ad).permit(:scale, :start_date, :end_date, :lat, :lng, :url, :title, :description)
  end	
end