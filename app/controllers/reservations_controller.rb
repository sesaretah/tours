class ReservationsController < ApplicationController
  before_filter :find_tour, only: [:passengers, :verification, :new, :verify_reservations]
  def verification

  end

  def passengers

  end

  def verify_reservations
    @reservations = Reservation.where(tour_id: @tour.id, user_id: current_user.id, status: false)
    for reservation in @reservations
      reservation.status =  true
      reservation.save
    end
  end

  def new
    @reservation = Reservation.new
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @tour = @reservation.tour
    @reservation.destroy
  end

  def find_tour
    @tour = Tour.find(params[:tour_id])
  end
end
