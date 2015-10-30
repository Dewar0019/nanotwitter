module UserSession
  def user
    @user ||= User.find_by(id: params[:id]) || halt(404)
  end

  ##
  # save user_id to session
  def login(user)
    session[:user_id] = user.id
  end

  ##
  # return current logged in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  ##
  # returns true if given user is the current user
  def current_user?(user)
    user.id = session[:user_id]
  end

  def login?
    session.key?(:user_id)
  end

  def logout
    session.delete(:user_id)
  end

  def link_to(link_name, url)
    "<a href=#{url}> #{link_name} </a>"
  end

  def h(text)
    Rack::Utils.escape_html(text)
  end
end

helpers UserSession
