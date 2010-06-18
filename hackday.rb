require "rubygems"
require 'sinatra'
require 'dm-core'
require 'sinatra-authentication'
require 'environment'
require 'haml'


error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

get '/' do
  haml :index
end
