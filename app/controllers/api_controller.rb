class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:tour_packages, :tour_package, :tour, :reservation, :login, :sign_up, :tour_reservations, :delete_reservation, :verify_reservation, :my_reservations, :blogs, :blog, :provinces]
  before_action :is_admin, only: [:reservation, :tour_reservations, :my_reservations]
  include ActionView::Helpers::TextHelper

  def login
    if User.find_by_username(params['username']).try(:valid_password?, params[:password])
      @user = User.find_by_username(params['username'])
      render :json => {result: 'OK', token: JWTWrapper.encode({ user_id: @user.id }), user_id: @user.id}.to_json , :callback => params['callback']
    else
      render :json => {result: 'ERROR',  error: I18n.t(:doesnt_match) }.to_json , :callback => params['callback']
    end
  end

  def provinces
    @provinces = Province.all.order('name')
    render :json => {result: 'OK', provinces: @provinces}.to_json , :callback => params['callback']
  end


  def sign_up
    @user = User.new(username: params['username'], mobile: params['username'], password: params['password'], password_confirmation: params['password_confirmation'])
    if @user.save
      @profile = Profile.create(user_id: @user.id, name: params[:name], province_id: params[:province_id])
      render :json => {result: 'OK', token: JWTWrapper.encode({ user_id: @user.id })}.to_json, :callback => params['callback']
    else
      render :json => {result: 'ERROR', error: @user.errors }.to_json , :callback => params['callback']
    end
  end

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

  def blogs
    if params[:q].blank?
      if params[:category_id].blank?
        @blogs = Blog.all.order('updated_at desc').paginate(:page => params[:page], :per_page => 10)
      else
        @blogs = Blog.where(category_id: params[:category_id]).order('updated_at desc').paginate(:page => params[:page], :per_page => 10)
      end
    else
      @blogs = Blog.search params[:q], star: true
    end
    @result = []
    for blog in @blogs
      @result << {id: blog.id, title: blog.title, content: "" ,'cover' => request.base_url + blog.cover('medium'), updated_at: blog.updated_at}
    end
    render :json => @result.to_json, :callback => params['callback']
  end

  def blog
    @blog = Blog.find(params[:id])
    @result = {id: @blog.id, title: @blog.title, content: @blog.content.gsub('/system/', request.base_url + '/system/')}
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
      else
        @departure_carrier = ""
      end
      @arrival_transportations = tour.transportations.where(leg: "Arrival").order(:created_at).first
      if !@arrival_transportations.blank?
        @arrival_carrier = "#{I18n.t(@arrival_transportations.transportable_type.downcase.pluralize)}:  #{@arrival_transportations.transportable_type.classify.constantize.find(@arrival_transportations.transportable_id).name rescue nil}"
      else
        @arrival_carrier = ""
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

      @price_range = ''
      @upper_price = tour.pricings.order('value desc').limit(2).first
      @down_price = tour.pricings.order('value desc').limit(2).last
      if !@upper_price.blank? && !@down_price.blank?
        @price_range = "#{@upper_price.value}-#{@down_price.value}"
      end
      @result << {id: tour.id, departure: tour.jalali_start_date, departure_carrier: @departure_carrier, arrival: tour.jalali_end_date, arrival_carrier: @arrival_carrier, accomodations: @accomodations, price: @price_range, remained_capacity: tour.remained_capacity}
    end
    @tour_package_result = {id: @tour_package.id, title: @tour_package.title, content: "#{@tour_package.days} #{I18n.t(:days)} #{I18n.t(:and)} #{@tour_package.nights} #{I18n.t(:nights)}" ,'cover' => request.base_url + @tour_package.cover('medium'), updated_at: @tour_package.updated_at}
    render :json => {result: 'OK', tour_package: @tour_package_result, tours: @result}.to_json , :callback => params['callback']
  end

  def tour
    @tour = Tour.find(params[:id])
    @transportations = []
    @pricings = []
    @result = []
    @photos = []
    for transportation in @tour.transportations
      @transportations << {type: I18n.t(transportation.transportable_type.downcase), name: transportation.transportable_type.classify.constantize.find(transportation.transportable_id).name, leg: I18n.t(transportation.leg.downcase) }
    end
    for pricing in @tour.pricings
      @pricings << {title: pricing.price_type.title, value: pricing.value}
    end

    for photo in @tour.photos('large')
      @photos << {url:  request.base_url + photo[:url], id: photo[:id]}
    end

    @result << {id: @tour.id, tour_package: @tour.tour_package ,details: @tour.details ,title: @tour.tour_package.title + " (#{@tour.tour_package.days} #{I18n.t(:days)} #{I18n.t(:and)} #{@tour.tour_package.nights} #{I18n.t(:nights)})", departure: @tour.jalali_start_date, arrival: @tour.jalali_end_date, accomodations: @tour.hotels, transportations: @transportations, pricings: @pricings, photos: @photos, remained_capacity: @tour.remained_capacity}
    render :json => {result: 'OK', result:@result}.to_json , :callback => params['callback']
  end

  def reservation
    @passenger = Passenger.new
    @passenger.name = params[:name]
    @passenger.surename = params[:surename]
    @passenger.father_name = params[:father_name]
    @passenger.passport_no = params[:passport_no]
    @passenger.ssn = params[:ssn]
    @passenger.sex = params[:sex]
    @passenger.place_of_birth = params[:place_of_birth]
    @passenger.birthdate = params[:birthdate]
    @passenger.en_name = params[:en_name]
    @passenger.en_surename = params[:en_surename]
    @passenger.en_fathername = params[:en_fathername]
    if @passenger.save
      @tour = Tour.find(params['tours'][0]['id'])
      manage_reservations(@passenger.id,params['tours'][0]['id'])
      render :json => {result: 'OK', passenger: @passenger, tour: @tour, remained_capacity: @tour.remained_capacity}.to_json , :callback => params['callback']
    end
  end

  def tour_reservations
    @tour = Tour.find(params[:id])
    @reservations = Reservation.where(tour_id: @tour.id, user_id: current_user.id, status: false)
    @passengers = []
    for reservation in @reservations
      @passengers << reservation.passenger
    end
    render :json => {result: 'OK', passengers: @passengers, tour: @tour, remained_capacity: @tour.remained_capacity}.to_json , :callback => params['callback']
  end

  def delete_reservation
    @tour = Tour.find(params[:id])
    @reservation = Reservation.where(tour_id: @tour.id, user_id: current_user.id, passenger_id: params[:passenger_id],status: false).first
    if !@reservation.blank?
      @reservation.destroy
    end
    @reservations = Reservation.where(tour_id: @tour.id, user_id: current_user.id, status: false)
    @passengers = []
    for reservation in @reservations
      @passengers << reservation.passenger
    end
    render :json => {result: 'OK', passengers: @passengers, tour: @tour, remained_capacity: @tour.remained_capacity}.to_json , :callback => params['callback']
  end

  def verify_reservation
    @tour = Tour.find(params[:id])
    @reservations = Reservation.where(tour_id: @tour.id, user_id: current_user.id, status: false)
    @passengers = []
    for reservation in @reservations
      reservation.status =  true
      reservation.save
      @passengers << reservation.passenger
    end
    render :json => {result: 'OK', passengers: @passengers, tour: @tour}.to_json , :callback => params['callback']
  end

  def verified_reservations
    @tour = Tour.find(params[:id])
    @reservations = Reservation.where(tour_id: @tour.id, user_id: current_user.id, status: true)
    @passengers = []
    for reservation in @reservations
      @passengers << reservation.passenger
    end
    render :json => {result: 'OK', passengers: @passengers, tour: @tour}.to_json , :callback => params['callback']
  end

  def my_reservations
    @result = []
    current_user.reservations.all.group_by(&:tour).each do |tour, reservations|
      @result << {tour_package: tour.tour_package, tour:  {id: tour.id , departure: tour.jalali_start_date, arrival: tour.jalali_end_date}}
    end
    render :json => {result: 'OK', result: @result}.to_json , :callback => params['callback']
  end

  def is_admin
    if current_user.blank?
      head(403)
    end
  end


end
