module AppHelpers

  def inBase(title, content)
    haml :index, :locals => {:title => title, :content => content}
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
end