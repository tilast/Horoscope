module AppHelpers

  def inBase(title, content, extraHeader = nil)
    datePicker = "$(function() { $('#datepicker').datepicker({ minDate: '-50Y', maxDate: +7, dateFormat: 'yy/mm/dd', showOn: 'button', buttonText: 'Select date', changeYear: true, changeMonth: true });});"
    haml :index, :locals => {:title => title, :content => content, :extraHeader => extraHeader, :datePicker => datePicker}
  end

  def equalPasswords?(password, password_again)
    password == password_again
  end

  def emptyFields?(form, fields = [])
    result = false

    if fields.empty?
      form.each do |field|
        result = true if field.empty?
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

  def parseDate(str)
    result = {}
    result["year"], result["month"], result["day"] = str.split(/[^\d]+/)
    Date.new(result["year"].to_i, result["month"].to_i, result["day"].to_i)
  end
end