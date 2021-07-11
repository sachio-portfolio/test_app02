class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google
    callback_from :google
  end

  def facebook
    callback_from :facebook
  end

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      # bypass_sign_in(@user)
      # redirect_to @user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  # def failure
  #   redirect_to root_url
  # end

end
