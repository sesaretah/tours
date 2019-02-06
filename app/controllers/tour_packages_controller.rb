class TourPackagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :set_tour_package, only: [:show, :edit, :update, :destroy, :check, :change_rank, :change_status, :change_size]
  before_action :check_user, only: [:new, :edit, :update, :destroy, :create]
  before_action :verify_ads, only: [:change_status, :change_size, :check]

  def change_status
    if params[:status] == "1"
      @tour_package.status = 1
    else
      @tour_package.status = 0
    end
    @tour_package.save
  end

  def change_size
    if params[:size] == "2"
      @tour_package.size = 2
    else
      @tour_package.size = 1
    end
    @tour_package.save
  end

  def change_rank
    if !grant_access("ability_to_verify_ads", current_user)
      head(403)
    else
      if params[:move] == 'up'
        @tour_package.rank += 1
      else
        @tour_package.rank -= 1
      end
      @tour_package.save
      redirect_to '/'
    end
  end

  def check
    if params[:to] == 'check'
      @tour_package.view_in_homepage = true
    else
      @tour_package.view_in_homepage = false
    end
    @tour_package.save
  end

  def upload

  end
  # GET /tour_packages
  # GET /tour_packages.json
  def index
    @tour_packages = TourPackage.all
  end

  # GET /tour_packages/1
  # GET /tour_packages/1.json
  def show
  end

  # GET /tour_packages/new
  def new
    @tour_package = TourPackage.new
  end

  # GET /tour_packages/1/edit
  def edit
  end

  # POST /tour_packages
  # POST /tour_packages.json
  def create
    @tour_package = TourPackage.new(tour_package_params)

    respond_to do |format|
      if @tour_package.save
        format.html { redirect_to @tour_package.id, notice: 'Tour package was successfully created.' }
        format.json { render :show, status: :created, location: @tour_package }
      else
        format.html { render :new }
        format.json { render json: @tour_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tour_packages/1
  # PATCH/PUT /tour_packages/1.json
  def update
    respond_to do |format|
      if @tour_package.update(tour_package_params)
        if params['upload'].blank?
          format.html { redirect_to @tour_package, notice: 'Tour package was successfully updated.' }
        else
          format.html { redirect_to "/tour_packages", notice: 'Tour package was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @tour_package }
      else
        format.html { render :edit }
        format.json { render json: @tour_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tour_packages/1
  # DELETE /tour_packages/1.json
  def destroy
    @tour_package.destroy
    respond_to do |format|
      format.html { redirect_to tour_packages_url, notice: 'Tour package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tour_package
    @tour_package = TourPackage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tour_package_params
    params.require(:tour_package).permit(:title, :days, :nights, :details, :agency_id, :uuid)
  end

  def verify_ads
    if !grant_access("ability_to_verify_ads", current_user)
      head(403)
    end
  end

  def check_user
    if !grant_access("ability_to_post_tour_packages", current_user)
      head(403)
    end
  end
end
