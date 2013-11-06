class User
  include DataMapper::Resource

  property :id,		    Serial		# auto increment id
  property :login,	  String		# login of user
  property :password,	String    # password
  property :birthday, DateTime
  property :sign,     String

  def correctPassword?(pass)
    password == Digest::MD5.hexdigest(pass)
  end

end