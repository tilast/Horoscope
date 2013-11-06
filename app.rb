class App < Sinatra::Base
  helpers AppHelpers
  enable :sessions
  register Sinatra::Flash

  get "/" do
    if session[:login]
      haml :index, :locals => {:title => "main", :content => "content"}\
    else
      redirect "/login"
    end
  end
end