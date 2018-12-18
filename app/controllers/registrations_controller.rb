class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :except => [:new, :update, :create]
  def new
    super
  end

  def create
    @user = User.new(username: params[:user][:mobile], email: params[:user][:email], mobile: params[:user][:mobile], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    respond_to do |format|
      if @user.save
        @profile = Profile.create(name: params[:name], phone: params[:user][:mobile], sex: params[:sex])
        format.html { redirect_to '/', notice: 'Welcome' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    super
  end

end
