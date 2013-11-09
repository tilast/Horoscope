class App < Sinatra::Base
  get('/style.css') { scss "css/style".to_sym }
  get('/play.js') {  "js/play.js".to_sym }
end