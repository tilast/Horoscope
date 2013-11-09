require 'net/http'
require "json"
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'dm-migrations'
require "./models/Horoscope.rb"
require "date"

Dir.mkdir 'tmp' unless File.exists? 'tmp'
File.new("#{Dir.pwd}/tmp/test.db", "w") unless File.exists? "#{Dir.pwd}/tmp/test.db"

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/tmp/test.db")

DataMapper.finalize
DataMapper.auto_upgrade!

class Grabber
  class << self
    def grab
      now = DateTime.now
      today  = Date.new(now.year, now.month, now.day)
      date_range = [today, ((today + 1)..(today + 6)).to_a.take_while { |day| !day.monday? }].flatten

      date_range.each do |value|
        horoscope = Horoscope.new
        horoscope[:date] = value

        Horoscope::SIGNS.each do |sign|
          resp = Net::HTTP.get_response(URI.parse(URI.escape("http://widgets.fabulously40.com/horoscope.json?sign=" + sign + "&date=" + value.strftime("%Y-%d-%m"))))
          result = JSON.parse(resp.body)
          horoscope[sign.to_sym] = result.empty? ? "Sorry, today we don't have horoscope for you :(" : result["horoscope"]["horoscope"]
        end

        horoscope.save
      end
    end
  end
end