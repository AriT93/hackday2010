require "rubygems"
require "sinatra"
require "hackday.rb"
require "dm-core"
require "sinatra-authentication"

set :environment, :devlopment


run Sinatra::Application
