class App < Sinatra::Base

  get %r{/(today|tomorrow|yesterday)(/[\w]+)?(\.json)?} do
    user = login

    sign = params[:captures][1] ? (params[:captures][1])[1..-1] : user.sign
    horoscope = {}
    case params[:captures][0]
      when "today"
        horoscope = get_horoscope(0, sign)
      when "tomorrow"
        horoscope = get_horoscope(1, sign)
      when "yesterday"
        horoscope = get_horoscope(-1, sign)
      else
        horoscope[:horoscope] = "Internal error"
    end

    if params[:captures][2] == ".json"
      result = JSON.generate({:horoscope => horoscope, :sign => sign})
    else
      view_horoscope = haml :horoscope, :locals => {
          :horoscope => horoscope[:horoscope],
          :day => params[:captures][0],
          :sign => sign,
          :nav_links => get_nav_links(params[:captures][0], sign, horoscope[:yesterday], horoscope[:tomorrow]),
          :horoscope_links => get_horoscope_links(params[:captures][0])
      }
      result = in_base("horoscope", view_horoscope)
    end

    result
  end

end