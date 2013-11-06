# models
require "./models"
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'dm-migrations'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'haml'
require "date"
require "./helpers/AppHelpers"

# setup controllers
require "./app.rb"
Dir['./controllers/*.rb'].each {|file| require file}

run App