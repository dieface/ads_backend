class AdsController < ApplicationController

	# before_action :login_required, :only => [:new, :create, :edit, :update, :destroy]
	before_action :authenticate_user!

	def available
		# @ads = current_user.ads.find_by aasm_state: 'available'
		
		time_current = Time.current
		@ads = current_user.ads.where("start_date <= ? AND end_date >= ?", time_current, time_current)

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

		time_current = Time.current
		@ads = current_user.ads.where("aasm_state == ?", 'unavailable')

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
		if @ad.save
			redirect_to ads_path
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

	private

  def ad_params
		params.require(:ad).permit(:scale, :start_date, :end_date, :lat, :lng, :url, :title, :description, :photos_attributes => [:image])
		# params.require(:ad).permit(:scale, :start_date, :end_date, :lat, :lng, :url, :title, :description)
  end

end
