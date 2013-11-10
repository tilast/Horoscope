require 'bundler'
Bundler.require

empty_db = false
Dir.mkdir 'tmp' unless File.exists? 'tmp'
unless File.exists?("#{Dir.pwd}/tmp/test.db") do
  File.new("#{Dir.pwd}/tmp/test.db", "w")
  empty_db = true
end

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/tmp/test.db")

Dir['./models/*.rb'].each {|file| require file}

DataMapper.finalize
DataMapper.auto_upgrade!

if empty_db
  Grabber.grab
end