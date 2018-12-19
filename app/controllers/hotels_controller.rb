class HotelsController < ApplicationController
  def create
    @hotel = Hotel.create(name: params[:name], stars: params[:stars], city: params[:city])
  end
end
