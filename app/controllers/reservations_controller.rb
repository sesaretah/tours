class ReservationsController < ApplicationController
  before_filter :find_tour, only: [:passengers, :verification, :new]
  def verification

  end

  def passengers

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
