class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:tour_packages, :tour_package]
  before_action :is_admin, only: []
  include ActionView::Helpers::TextHelper

  def tour_packages
    if params[:q].blank?
      if params[:category_id].blank?
        @tour_packages = TourPackage.all.order('updated_at desc').paginate(:page => params[:page], :per_page => 10)
      else
        @tour_packages = TourPackage.where(category_id: params[:category_id]).order('updated_at desc').paginate(:page => params[:page], :per_page => 10)
      end
    else
      @tour_packages = TourPackage.search params[:q], star: true
    end
    @result = []
    for tour_package in @tour_packages
      @result << {id: tour_package.id, title: tour_package.title, content: "#{tour_package.days} #{I18n.t(:days)} #{I18n.t(:and)} #{tour_package.nights} #{I18n.t(:nights)}" ,'cover' => request.base_url + tour_package.cover('medium'), updated_at: tour_package.updated_at}
    end
    render :json => @result.to_json, :callback => params['callback']
  end

  def tour_package
    @tour_package = TourPackage.find(params[:id])
    @tours = @tour_package.tours
    @result = []
    for tour in @tours
      @departure_transportations = tour.transportations.where(leg: "Departure").order(:created_at).first
      if !@departure_transportations.blank?
        @departure_carrier = "#{I18n.t(@departure_transportations.transportable_type.downcase.pluralize)}:  #{@departure_transportations.transportable_type.classify.constantize.find(@departure_transportations.transportable_id).name}"
      end
      @arrival_transportations = tour.transportations.where(leg: "Arrival").order(:created_at).first
      if !@arrival_transportations.blank?
        @arrival_carrier = "#{I18n.t(@arrival_transportations.transportable_type.downcase.pluralize)}:  #{@departure_transportations.transportable_type.classify.constantize.find(@arrival_transportations.transportable_id).name}"
      end
      @accomodations = []
      @accomodation1 = tour.accomodations.order('nights desc').limit(2).first
      if !@accomodation1.blank?
         @accomodations << {name: Hotel.find(@accomodation1.accomodable_id).name, stars: Hotel.find(@accomodation1.accomodable_id).stars}
      end
      @accomodation2 = tour.accomodations.order('nights desc').limit(2).last
      if !@accomodation1.blank? && @accomodation1 != @accomodation2
        @accomodations << {name: Hotel.find(@accomodation1.accomodable_id).name, stars: Hotel.find(@accomodation1.accomodable_id).stars}
      end
      @result << {id: tour.id, departure: tour.jalali_start_date, departure_carrier: @departure_carrier, arrival: tour.jalali_end_date, arrival_carrier: @arrival_carrier, accomodations: @accomodations}
    end
    @tour_package_result = {id: @tour_package.id, title: @tour_package.title, content: "#{@tour_package.days} #{I18n.t(:days)} #{I18n.t(:and)} #{@tour_package.nights} #{I18n.t(:nights)}" ,'cover' => request.base_url + @tour_package.cover('medium'), updated_at: @tour_package.updated_at}
    render :json => {result: 'OK', tour_package: @tour_package_result, tours: @result}.to_json , :callback => params['callback']
  end
end
