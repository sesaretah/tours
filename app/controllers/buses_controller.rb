class BusesController < ApplicationController
  def options
    @buses = Bus.all
    @results = []
    for bus in @buses
      @results << {'name' => bus.name, 'id' => bus.id}
    end
    render :json => @results.to_json, :callback => params['callback']
  end
  def create
    @buses = Bus.create(name: params[:name], capacity: params[:capacity])
  end
end
