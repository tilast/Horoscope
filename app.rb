class App < Sinatra::Base
  helpers AppHelpers
  enable :sessions
  register Sinatra::Flash

  get "/" do
    if session[:login]
      inBase("main page", "main")
    else
      redirect "/login"
    end
  end
end