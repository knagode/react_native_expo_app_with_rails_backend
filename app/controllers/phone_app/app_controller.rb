class PhoneApp::AppController < ApplicationController
  def show
    session[:is_phone_app] = true

    %w(expo_push_token).each do |key|
      session[key] = params[key]  if params[key]
    end

    # login user based on auth_token
    if !current_user && params[:auth_token].to_s.length > 20
      user = User.find_by(auth_token: params[:auth_token])
      sign_in(:user, user) if user
    end

    # store expo_push_token if it has not yet been saved
    if session[:expo_push_token] && current_user && !current_user.expo_push_token
      current_user.update(expo_push_token: session[:expo_push_token])
    end

    redirect_to params[:url], allow_other_host: Rails.env.development? if params[:url].present?
  end

  def sign_out; end
end
