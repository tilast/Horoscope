class App < Sinatra::Base
  get('/style.css') { scss "css/style".to_sym }
end