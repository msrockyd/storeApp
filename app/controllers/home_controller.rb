class HomeController < ApplicationController
  def index
  	@products = Product.all.order("created_at DESC")

  	respond_to do |format|
        format.html 
        format.json { render json: @products }
    end
  end

  def login_last_url
	cookies[:last_url] = params[:last_url]
	render :nothing => true, :status => 200, :content_type => 'text/html'	
  end

end
