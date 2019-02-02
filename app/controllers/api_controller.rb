class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => []
  before_action :load_agency, only: []
  before_action :is_admin, only: []
  include ActionView::Helpers::TextHelper

  def tour_packages

  end
end
