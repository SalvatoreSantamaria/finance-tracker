class User::RegistrationsController < Devise::RegistrationsController
    #inheirits everthing from Devise, but will look in User first and then Devise
    before_action :configure_permitted_parameters
    
    protected

    def configure_permitted_parameters
        #need to allow first name and last name to be permitted
        devise_parameter_sanitizer.permit(:sign_up, keys:[:first_name, :last_name])
        devise_parameter_sanitizer.permit(:account_update, keys:[:first_name, :last_name])
    end

end