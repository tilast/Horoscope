class App < Sinatra::Base

  get "/signup" do
    if session[:login]
      redirect "/"
    else
      signup = haml :signup
      in_base("Sign up", signup, get_jquery_ui + get_datepicker)
    end
  end

  post %r{/signup(\.json)?} do

    if empty_fields?(params, [:login, :password, :password_again, :birthday, :go_signup])
      problem = "Some reqiuired fields are empty"
      if params[:captures]
        JSON.generate(:error => problem)
      else
        flash[:signup_error] = problem
        redirect "/signup"
      end
    else
      if User.first(:login => params[:login])
        problem = "User already exists"
        if params[:captures]
          JSON.generate(:error => problem)
        else
          flash[:signup_error] = "User already exists"
          redirect "/signup"
        end
      elsif !valid_date?(params[:birthday])
        problem = "Wrong birthday"
        if params[:captures]
          JSON.generate(:error => problem)
        else
          flash[:signup_error] = problem
          redirect "/signup"
        end
      elsif equal_passwords?(params[:password], params[:password_again])
        User.create(:login => params[:login], :password => Digest::MD5.hexdigest(params[:password]), :birthday => parse_date(params[:birthday]), :sign => User.define_sign(params[:birthday]))
        session[:login] = params[:login]
        if params[:captures]
          JSON.generate(:redirect => "/")
        else
          redirect "/"
        end
      else
        problem = "Passwords are not equal"
        if params[:captures]
          JSON.generate(:error => problem)
        else
          flash[:signup_error] = problem
          redirect "/signup"
        end
      end
    end
  end
end