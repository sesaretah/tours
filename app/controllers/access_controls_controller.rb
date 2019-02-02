class AccessControlsController < ApplicationController
  before_action :check_user
  before_action :set_access_control, only: [:show, :edit, :update, :destroy]

  # GET /access_controls
  # GET /access_controls.json
  def index
    @access_controls = AccessControl.all
  end

  # GET /access_controls/1
  # GET /access_controls/1.json
  def show
  end

  # GET /access_controls/new
  def new
    @access_control = AccessControl.new
  end

  # GET /access_controls/1/edit
  def edit
  end

  # POST /access_controls
  # POST /access_controls.json
  def create
    @access_control = AccessControl.new(access_control_params)

    respond_to do |format|
      if @access_control.save
        format.html { redirect_to @access_control, notice: 'Access control was successfully created.' }
        format.json { render :show, status: :created, location: @access_control }
        format.js
      else
        format.html { render :new }
        format.json { render json: @access_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_controls/1
  # PATCH/PUT /access_controls/1.json
  def update
    respond_to do |format|
      if @access_control.update(access_control_params)
        format.html { redirect_to @access_control, notice: 'Access control was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_control }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @access_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_controls/1
  # DELETE /access_controls/1.json
  def destroy
    @access_control.destroy
    respond_to do |format|
      format.html { redirect_to access_controls_url, notice: 'Access control was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_control
      @access_control = AccessControl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_control_params
      params.require(:access_control).permit(:ability_to_post_tour_packages, :ability_to_post_blog, :ability_to_verify_ads, :ability_to_change_categories, :ability_to_change_faqs, :ability_to_change_roles, :ability_to_assign_roles, :uuid, :role_id)
    end

    def check_user
      if !grant_access("ability_to_change_roles", current_user)
        head(403)
      end
    end
end
