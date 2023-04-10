class ApplicationController < ActionController::Base
  def after_sign_out_path_for(resource_or_scope)
    if params[:is_phone_app] # session is already deleted before and can not be used here
      phone_app_sign_out_path
    else 
      new_user_session_path
    end
  end

  def after_sign_in_path_for(resource)
    if session[:is_phone_app]
      phone_app_root_path
    else 
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    if session[:is_phone_app]
      phone_app_root_path
    else 
      root_path
    end
  end
end
