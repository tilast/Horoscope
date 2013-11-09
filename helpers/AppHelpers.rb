module AppHelpers

  def in_base(title, content = nil, extra_header = nil)
    haml :index, :locals => {:title => title, :content => content, :extra_header => extra_header, :auth_links => get_auth_links}
  end

  def equal_passwords?(password, password_again)
    password == password_again
  end

  def empty_fields?(form, fields = [])
    result = false

    if fields.empty?
      form.each do |field|
        result = true if !field || field.empty?
      end
    else
      fields.each do |field|
        result = true if form[field].empty?
      end
    end

    result
  end

  def valid_date?(dt)
    begin
      Date.parse(dt)
      true
    rescue => e
      false
    end
  end

  def parse_date(str)
    result = {}
    result["year"], result["month"], result["day"] = str.split(/[^\d]+/)
    Date.new(result["year"].to_i, result["month"].to_i, result["day"].to_i)
  end

  def login
    redirect "/login" unless session[:login]
    user = User.first(:login => session[:login])
    redirect "/login" if user.nil?

    user
  end

  def logged?
    session[:login] ? true : false
  end

  def get_horoscope(offset, sign)
    now = DateTime.now
    date = Date.new(now.year, now.month, now.day) + offset

    horoscope = Horoscope.first(:date => Date.new(date.year, date.month, date.day))

    if horoscope.nil?
      content = "Sorry, some problems :'("
    else
      content = horoscope[sign.to_sym]
    end
    result = {}
    result[:yesterday], result[:tomorrow] = !!Horoscope.first(:date => Date.new(now.year, now.month, now.day - 1)), !!Horoscope.first(:date => Date.new(now.year, now.month, now.day + 1))
    result[:horoscope] = content

    result
  end

  def get_jquery_ui
    engine = Haml::Engine.new('%script{:src => "http://code.jquery.com/ui/1.10.3/jquery-ui.js"}
%link{:rel => "stylesheet", :href => "http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"}')
    engine.render
  end

  def get_datepicker
    "<script type='text/javascript'>$(function() { $('#datepicker').datepicker({ dateFormat: 'yy/mm/dd', showOn: 'button', buttonText: 'Select date', changeYear: true, changeMonth: true,   yearRange: '1950:2012' });});</script>"
  end

  def get_nav_links(day, sign = "", is_yesterday, is_tomorrow)

    sign = !!sign ? "/" + sign : ""

    yesterday, today, tomorrow = {:url => "/yesterday" + sign, :title => "Yesterday"}, {:url => "/today" + sign, :title => "Today"}, {:url => "/tomorrow" + sign, :title => "Tomorrow"}

    result = []

    case day
      when "yesterday"
        result << today
        if is_tomorrow
          result << tomorrow
        end
      when "today"
        if is_yesterday
        end
        result << yesterday
        if is_tomorrow
          result << tomorrow
        end
      when "tomorrow"
        if is_yesterday
          result << yesterday
        end
        result << today
      else
        result = []
    end
  end

  def get_auth_links
    if logged?
      [
          {:url => "/login", :title => "Logout"}
      ]
    else
      [
          {:url => "/login", :title => "Login"},
          {:url => "/signup", :title => "Sign up"}
      ]
    end
  end

  def get_horoscope_links(day)
    links = []
    Horoscope::SIGNS.each do |sign|
      links << {:url => "/" + day + "/" + sign, :title => sign}
    end
    links
  end
end