require 'bundler'
Bundler.require

Dir.mkdir 'tmp' unless File.exists? 'tmp'
File.new("#{Dir.pwd}/tmp/test.db", "w") unless File.exists? "#{Dir.pwd}/tmp/test.db"

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/tmp/test.db")

Dir['./models/*.rb'].each {|file| require file}

DataMapper.finalize
DataMapper.auto_upgrade!