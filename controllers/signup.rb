class App < Sinatra::Base

  get "/signup" do
    if session[:login]
      redirect "/"
    else
      signup = haml :signup
      in_base("Sign up", signup, get_jquery_ui)
    end
  end

  post "/signup" do

    if empty_fields?(params, [:login, :password, :password_again, :birthday, :go_signup])
      flash[:signup_error] = "Some reqiuired fields are empty"
      redirect "/signup"
    else
      if User.first(:login => params[:login])
        flash[:signup_error] = "User already exists"
        redirect "/signup"
      elsif !valid_date?(params[:birthday])
        flash[:signup_error] = "Wrong birthday"
        redirect "/signup"
      elsif equal_passwords?(params[:password], params[:password_again])
        User.create(:login => params[:login], :password => Digest::MD5.hexdigest(params[:password]), :birthday => parse_date(params[:birthday]), :sign => User.define_sign(params[:birthday]))
        session[:login] = params[:login]
        redirect "/"
      else
        flash[:signup_error] = "Passwords are not equal"
        redirect "/signup"
      end
    end

  end
end