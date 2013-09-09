class CustomFailure < Devise::FailureApp
  def redirect_url
    after_sign_in_error_path_for(resource)
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end