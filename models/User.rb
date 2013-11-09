class User
  include DataMapper::Resource

  property :id,		    Serial		# auto increment id
  property :login,	  String		# login of user
  property :password,	String    # password
  property :birthday, DateTime
  property :sign,     String

  def correct_password?(pass)
    password == Digest::MD5.hexdigest(pass)
  end

  def self.define_sign(date)
    result = {}
    result["year"], result["month"], result["day"] = date.split(/[^\d]+/)
    date = Date.new(result["year"].to_i, result["month"].to_i, result["day"].to_i)

    sign = ""
    if date.is_a?(Date)
      if ((Date.new(date.year, 3, 21)..Date.new(date.year, 4, 20)).to_a.include? date)
        sign = "aries"
      elsif ((Date.new(date.year, 4, 21)..Date.new(date.year, 5, 20)).to_a.include? date)
        sign = "taurus"
      elsif ((Date.new(date.year, 5, 21)..Date.new(date.year, 6, 20)).to_a.include? date)
        sign = "gemini"
      elsif ((Date.new(date.year, 6, 21)..Date.new(date.year, 7, 22)).to_a.include? date)
        sign = "cancer"
      elsif ((Date.new(date.year, 7, 23)..Date.new(date.year, 8, 22)).to_a.include? date)
        sign = "leo"
      elsif ((Date.new(date.year, 8, 23)..Date.new(date.year, 9, 22)).to_a.include? date)
        sign = "virgo"
      elsif ((Date.new(date.year, 9, 23)..Date.new(date.year, 10, 22)).to_a.include? date)
        sign = "libra"
      elsif ((Date.new(date.year, 10, 23)..Date.new(date.year, 11, 21)).to_a.include? date)
        sign = "scorpio"
      elsif ((Date.new(date.year, 11, 22)..Date.new(date.year, 12, 21)).to_a.include? date)
        sign = "sagittarius"
      elsif ((Date.new(date.year, 12, 22)..Date.new(date.year + 1, 1, 19)).to_a.include? date)
        sign = "capricorn"
      elsif ((Date.new(date.year + 1, 1, 20)..Date.new(date.year + 1, 2, 18)).to_a.include? date)
        sign = "aquarius"
      elsif ((Date.new(date.year + 1, 2, 19)..Date.new(date.year + 1, 3, 20)).to_a.include? date)
        sign = "pisces"
      end
    else
      false
    end
  end
end