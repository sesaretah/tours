class AirlinesController < ApplicationController
  def options
    @airlines = Airline.all
    @results = []
    for airline in @airlines
      @results << {'name' => airline.name, 'id' => airline.id}
    end
    render :json => @results.to_json, :callback => params['callback']
  end
  def create
    @airline = Airline.create(name: params[:name])
  end
end
