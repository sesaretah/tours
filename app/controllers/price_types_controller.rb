class PriceTypesController < ApplicationController

    def create
      @price_type = PriceType.create(title: params[:title])
    end
end
