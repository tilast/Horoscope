class App < Sinatra::Base

  get "/login" do
    session.delete(:login)
    login = haml :login
    inBase("login page", login)
  end

  post "/login" do
    if params[:go_login]
      user = User.first(:login => params[:login])

      if user && user.correctPassword?(params[:password])
        session[:login] = params[:login]
        redirect "/"
      else
        flash[:login_error] = "Invalid login or password"
        redirect "/login"
      end
    end
  end

  get "/signup" do
    if session[:login]
      redirect "/"
    else
      signup = haml :signup
      inBase("Sign up", signup)
    end
  end

  post "/signup" do

    if emptyFields?(params, [:login, :password, :password_again, :birthday, :go_signup])
      flash[:signup_error] = "Some reqiuired fields are empty"
      redirect "/signup"
    else
      if User.first(:login => params[:login])
        flash[:signup_error] = "User already exists"
        redirect "/signup"
      elsif !valid_date?(params[:birthday])
        flash[:signup_error] = "Wrong birthday"
        redirect "/signup"
      elsif equalPasswords?(params[:password], params[:password_again])
        User.create(:login => params[:login], :password => Digest::MD5.hexdigest(params[:password]), :birthday => parseDate(params[:birthday]), :sign => User.defineSign(params[:birthday]))
        User.defineSign(params[:birthday])
        session[:login] = params[:login]
        redirect "/"
      else
        flash[:signup_error] = "Passwords are not equal"
        redirect "/signup"
      end
    end

  end

  get "/account" do

  end

end