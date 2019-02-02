class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    @tour_packages = TourPackage.where(view_in_homepage: true).order('rank desc')
    @blogs = Blog.where(view_in_homepage: true).order('rank desc')
  end

  def landing
    render layout: 'layouts/landing'
  end
end
