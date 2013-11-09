class App < Sinatra::Base
  get "/" do
    if logged?
      redirect "/today"
    else
      loginForm = haml :login
      signupForm = haml :signup
      mainContent = haml :main, :locals => {:loginForm => loginForm, :signupForm => signupForm}
      in_base("Main page", mainContent, get_jquery_ui + get_datepicker)
    end
  end
end