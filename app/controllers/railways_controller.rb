class RailwaysController < ApplicationController

  def options
    @railways = Railway.all
    @results = []
    for railway in @railways
      @results << {'name' => railway.name, 'id' => railway.id}
    end
    render :json => @results.to_json, :callback => params['callback']
  end

  def create
    @railway = Railway.create(name: params[:name], wagon_type: params[:wagon_type], number_of_seats: params[:number_of_seats])
  end
end
