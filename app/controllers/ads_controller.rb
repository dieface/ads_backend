class AdsController < ApplicationController

	# before_action :login_required, :only => [:new, :create, :edit, :update, :destroy]
	before_action :authenticate_user!
	# after_save 		:write_json

	def available
		# @ads = current_user.ads.find_by aasm_state: 'available'
		@ads = current_user.ads.where("aasm_state == ?", 'available')

		# time_current = Time.current
		# @ads = current_user.ads.where("start_date <= ? AND end_date >= ?", time_current, time_current)

		@ads.each do |ad|
			if ad.aasm_state == "available"
				ad.aasm_state = "available"
				ad.save	
			end
		end

		@global_ads = @ads.where("scale == ?", 'Global')
		@city_ads = @ads.where("scale == ?", 'City')
		@road_ads = @ads.where("scale == ?", 'Road')
	end

	def unavailable
		# @ads = Ad.find_by aasm_state: 'unavailable'
		@ads = current_user.ads.where("aasm_state == ?", 'unavailable')

		# time_current = Time.current
		# @ads = current_user.ads.where("start_date > ?", time_current)

		@global_ads = @ads.where("scale == ?", 'Global')
		@city_ads = @ads.where("scale == ?", 'City')
		@road_ads = @ads.where("scale == ?", 'Road')		
	end

	def index
		@ads = Ad.all
	end

	def new
		@ad = Ad.new
		@photo = @ad.photos.new
	end

	def create
		@ad = current_user.ads.build(ad_params)
		@ad.aasm_state = "available"
		# @ad.start_date = DateTime.new(@ad.start_date.year, @ad.start_date.month, @ad.start_date.day, 0, 0, 0, @ad.time_zone_offset)
		# @ad.end_date = DateTime.new(@ad.end_date.year, @ad.end_date.month, @ad.end_date.day, 23, 59, 59, 0)
		# @ad.end_date = DateTime.new(@ad.end_date.year, @ad.end_date.month, @ad.end_date.day, 23, 59, 59, @ad.time_zone_offset)

		if @ad.save
			write_json
			# redirect_to ads_path
			redirect_to available_ads_path
		else
			render :new
		end
	end

	def edit
		@ad = current_user.ads.find(params[:id])
	end

	def update
		@ad = current_user.ads.find(params[:id])

		if @ad.update(ad_params)
			redirect_to ad_path(@ad)
		else
			render :edit
		end
	end

	def destroy
		@ad = current_user.ads.find(params[:id])
		@ad.destroy

		redirect_to ads_path
	end

	def image_full_path(img_url)
	    # request.protocol + request.host_with_port + img_url
	    "http://54.65.144.107" + img_url
	end	

	private

	def write_json
	  ads_json = []
	  Ad.where("aasm_state == ?", 'available').each do |ad|
	    ad_json = {
				"id" => ad.id,
				"scale" => ad.scale,
				"start_date" => ad.start_date,
				"end_date" => ad.end_date,
				"lat" => ad.lat,
				"lng" => ad.lng,
				"url" => ad.url,
				"title" => ad.title,
				"description" => ad.description,
				"created_at" => ad.created_at,
				"updated_at" => ad.updated_at,
				"user_id" => ad.user_id,
				"aasm_state" => ad.aasm_state,
				"photo_url" => image_full_path(ad.default_photo.image.url)
	    } 
	    ads_json << ad_json
	  end
	  File.open("public/ads.json","wb") do |f|
	    f.write(ads_json.to_json)
	  end 
	end

  def ad_params
		params.require(:ad).permit(:scale, :start_date, :end_date, :lat, :lng, :url, :title, :description, :time_zone_offset, :photos_attributes => [:image])
		# params.require(:ad).permit(:scale, :start_date, :end_date, :lat, :lng, :url, :title, :description)
  end

end
