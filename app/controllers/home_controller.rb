class HomeController < ApplicationController
  def index
    @tour_packages = TourPackage.where(view_in_homepage: true).order('rank desc')
    @blogs = Blog.where(view_in_homepage: true).order('rank desc')
  end

  def landing
    render layout: 'layouts/landing'
  end
end
