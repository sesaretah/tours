class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.all
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
  end

  # GET /tours/new
  def new
    @tour = Tour.new
  end

  # GET /tours/1/edit
  def edit
  end

  # POST /tours
  # POST /tours.json
  def create
    @tour = Tour.new(tour_params)
    extract_packages
    extract_dates
    respond_to do |format|
      if @tour.save
        extract_accomodations
        extract_prices
        extract_transportations
        format.html { redirect_to "/tours/#{@tour.uuid}", notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: @tour }
      else
        format.html { render :new }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    extract_dates
    respond_to do |format|
      if @tour.update(tour_params)
        format.html { redirect_to "/tours/#{@tour.uuid}", notice: 'Tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour.destroy
    respond_to do |format|
      format.html { redirect_to tours_url, notice: 'Tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def extract_transportations
    params.each do |name, value|
      if name =~ /carrier_(.+)$/
        Transportation.create(transportable_type: value.classify.constantize, transportable_id: params["transportation_id_#{$1}"] , tour_id: @tour.id, leg: params["leg_#{$1}"])
      end
    end
  end

  def extract_prices
    params.each do |name, value|
      if name =~ /price_(.+)$/
        Pricing.create(tour_id: @tour.rawid,  price_type_id: $1, value: value)
      end
    end
  end

  def extract_accomodations
    @accomodation_ids = []
    params.each do |name, value|
      if name =~ /accomodation_type_(.+)$/
        if !params["duration_#{$1}"].blank?
          Accomodation.create(tour_id: @tour.rawid, accomodable_type: 'Hotel', accomodable_id: value, nights: params["duration_#{$1}"])
        end
      end
    end
  end

  def extract_packages
    @tour_package = TourPackage.find(params[:tp])
    @tour.tour_package_id = @tour_package[:id]
  end

  def extract_dates
    @tour.start_date = JalaliDate.to_gregorian(params[:start_date_yyyy],params[:start_date_mm],params[:start_date_dd])
    @tour.end_date = JalaliDate.to_gregorian(params[:end_date_yyyy],params[:end_date_mm],params[:end_date_dd])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:start_date, :end_date, :price, :details, :tour_package_id, :uuid)
    end
end
