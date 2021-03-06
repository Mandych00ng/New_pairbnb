class ListingsController < ApplicationController

	def index
		if params[:search].present?
			Listing.reindex
			@listings = Listing.search(params[:search], page: params[:page], per_page: 3)

		else
			@listings = Listing.all.paginate(page: params[:page], per_page: 3)
		end
	end

	def show
		@listing = Listing.find(params[:id])
		@reservation = Reservation.new
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save 
			redirect_to listings_path
		else
			@msg = 'not saved'
			redirect_to root_path
		end
	end

private
	def listing_params
		params.require(:listing).permit(:name,:location, :pricing, :tag_list, {images:[]})
	end
end
