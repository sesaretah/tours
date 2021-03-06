class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :except => [:new, :update, :create]
  def new
    super
  end

  def create
    @username = params[:user][:mobile]
    @user = User.new(username: @username,mobile: params[:user][:mobile], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    respond_to do |format|
      if @user.save
        @profile = Profile.create(name: params[:user][:fullname], user_id: @user.id, phone_number: params[:user][:mobile])
        sign_in(@user)
        format.html { redirect_to after_sign_in_path_for(@user), notice: 'Welcome' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    super
  end

end
