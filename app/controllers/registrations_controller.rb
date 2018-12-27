class RegistrationsController < Devise::RegistrationsController
  def new
      # Override Devise default behaviour and create a profile as well
      build_resource({})
      resource.build_user_profile
      respond_with self.resource
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u|
        u.permit(:email, :password, :password_confirmation, :user_profile_attributes => [:first_name, :last_name, :business_name, :business_category_id, :website, :address, :phone_number, :office_number])
      }
    end
end
