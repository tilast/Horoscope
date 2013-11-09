class App < Sinatra::Base

  get "/login" do
    session.delete(:login)
    login = haml :login
    in_base("login page", login)
  end

  post "/login" do
    if params[:go_login]
      user = User.first(:login => params[:login])

      if user && user.correct_password?(params[:password])
        session[:login] = params[:login]
        redirect "/today"
      else
        flash[:login_error] = "Invalid login or password"
        redirect "/login"
      end
    end
  end
end