class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  require 'jalali_date'
  before_filter :authenticate_user!, :except => [:after_sign_in_path_for,:after_inactive_sign_up_path_for,     :after_sign_up_path_for]
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
  end

  def grant_access(ward, user)
    @flag = 0
    if Role.all.blank? || (Role.count == 1 && Assignment.count < 2) #when new app starts
      return true
    end
    if user.assignments.blank?
      return false
    end
    if user.current_role_id.blank?
      return false
    else
      @ac = AccessControl.where(role_id: user.current_role_id).first
      @flag = @ac["#{ward}"] && 1 || 0
    end

    if @flag == 0
      return false
    else
      return true
    end
  end

  def manage_reservations(passenger_id,tour_id)
    if !tour_id.blank?
      @tour = Tour.find(tour_id)
      @reservation = Reservation.create(passenger_id: passenger_id, tour_id: tour_id, user_id: current_user.id, status: false)
    end
  end

  def manage_uploads(id)
    if !params[:attachments].blank?
      @upload_ids = params[:attachments].split(',')
      for upload_id in @upload_ids
        if !upload_id.blank?
          @upload = Upload.find_by_id(upload_id)
          if !@upload.blank?
            @upload.uploadable_id = id
            @upload.save
          end
        end
      end
    end
  end

end
