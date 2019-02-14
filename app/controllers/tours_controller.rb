class ToursController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
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
        manage_uploads
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
        extract_accomodations
        extract_prices
        extract_transportations
        manage_uploads
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
    for transportation in @tour.transportations
      transportation.destroy
    end
    params.each do |name, value|
      if name =~ /carrier_(.+)$/
        if !value.blank?
          @transportable_type = value.singularize.classify.constantize
          @transportable_id = params["transportation_id_#{$1}"]
          @tour_id = @tour.id
          @leg = params["leg_#{$1}"]
          @hour = params["time_#{$1}"]['hour']
          @minute = params["time_#{$1}"]['minute']
          Transportation.create(transportable_type: @transportable_type, transportable_id: @transportable_id  , tour_id: @tour_id  , leg: @leg, transport_time: "#{@hour}:#{@minute}")
        end
      end
    end
  end

  def extract_prices
    for pricing in @tour.pricings
      pricing.destroy
    end
    params.each do |name, value|
      if name =~ /price_(.+)$/
        Pricing.create(tour_id: @tour.id,  price_type_id: $1, value: value)
      end
    end
  end

  def extract_accomodations
    for accomodation in @tour.accomodations
      accomodation.destroy
    end
    params.each do |name, value|
      if name =~ /accomodation_type_(.+)$/
        if !params["accomodation_type_#{$1}"].blank? && !params["duration_#{$1}"].blank?
          Accomodation.create(tour_id: @tour.id, accomodable_type: 'Hotel', accomodable_id: value, nights: params["duration_#{$1}"])
        end
      end
    end
  end

  def extract_packages
    @tour_package = TourPackage.find(params[:tp])
    @tour.tour_package_id = @tour_package.id
  end

  def extract_dates
    @tour.start_date = JalaliDate.to_gregorian(params[:start_date_yyyy],params[:start_date_mm],params[:start_date_dd])
    @tour.end_date = JalaliDate.to_gregorian(params[:end_date_yyyy],params[:end_date_mm],params[:end_date_dd])
  end

  def manage_uploads
    if !params[:attachments].blank?
      @upload_ids = params[:attachments].split(',')
      for upload_id in @upload_ids
        if !upload_id.blank?
          @upload = Upload.find_by_id(upload_id)
          if !@upload.blank?
            @upload.uploadable_id = @tour.id
            @upload.save
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:start_date, :end_date, :price, :details, :tour_package_id, :uuid, :capacity)
    end
end
