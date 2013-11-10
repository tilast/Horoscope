class App < Sinatra::Base
  configure do
    helpers AppHelpers
    enable :sessions
    register Sinatra::Flash
    set :public_folder, File.dirname(__FILE__) + '/static'
  end
end