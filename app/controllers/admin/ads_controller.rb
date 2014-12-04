class Admin::AdsController < AdminController

  def new
    @ad = Ad.new
    @photo = @ad.photos.new
  end

  def create
    @ad = Ad.new(ad_params)

    if @ad.save
      redirect_to admin_ads_path
    else
      render :new
    end
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def update
    @ad = Ad.find(params[:id])

    if @ad.update(ad_params)
      redirect_to admin_ads_path
    else
      render :edit
    end
  end

  def index
    @ads = Ad.all
  end

  private

  def ad_params
    params.require(:ad).permit(:scale, :start_date, :end_date, :lat, :lng, :url, :title, :descriptio, :photos_attributes => [:image])
  end
end
