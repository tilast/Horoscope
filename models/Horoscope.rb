class Horoscope
  include DataMapper::Resource

  property  :id,            Serial
  property  :date,          DateTime
  property  :aries,         Text,     :lazy => true
  property  :taurus,        Text,     :lazy => true
  property  :gemini,        Text,     :lazy => true
  property  :cancer,        Text,     :lazy => true
  property  :leo,           Text,     :lazy => true
  property  :virgo,         Text,     :lazy => true
  property  :libra,         Text,     :lazy => true
  property  :scorpio,       Text,     :lazy => true
  property  :sagittarius,   Text,     :lazy => true
  property  :capricorn,     Text,     :lazy => true
  property  :aquarius,      Text,     :lazy => true
  property  :pisces,        Text,     :lazy => true
end