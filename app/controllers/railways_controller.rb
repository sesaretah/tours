class RailwaysController < ApplicationController
  def create
    @railway = Railway.create(name: params[:name])
  end
end
