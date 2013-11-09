class App < Sinatra::Base
  configure do
    helpers AppHelpers
    enable :sessions
    register Sinatra::Flash
  end
end