class App < Sinatra::Base

  get "/login" do
    session.delete(:login)
    login = haml :login
    in_base("Login page", login)
  end

  post %r{/login(\.json)?} do
    if params[:go_login]
      user = User.first(:login => params[:login])

      if user && user.correct_password?(params[:password])
        session[:login] = params[:login]
        if params[:captures][0]
          JSON.generate({:redirect => "/today"})
        else
          redirect "/today"
        end
      else
        if params[:captures][0]
          JSON.generate({:error => "Invalid login or password"})
        else
          flash[:login_error] = "Invalid login or password"
          redirect "/login"
        end
      end
    end
  end
end