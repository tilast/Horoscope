require 'bundler'
Bundler.require
require "./Grabber"

Dir.mkdir 'tmp' unless File.exists? 'tmp'
empty_db = false
unless File.exists? "#{Dir.pwd}/tmp/test.db"
  File.new("#{Dir.pwd}/tmp/test.db", "w")
  empty_db = true
end

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/tmp/test.db")

Dir['./models/*.rb'].each {|file| require file}

DataMapper.finalize
DataMapper.auto_upgrade!

if empty_db
  Grabber.simple_grab
end