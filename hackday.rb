require "rubygems"
require 'environment'
require 'sinatra'
require 'dm-core'
require 'digest/sha1'
require 'sinatra-authentication'
require 'haml'
require 'rack-flash'

use Rack::Session::Cookie, :secret=>"supahsekrit is the bestes sekrit"
use Rack::Flash




error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  #define helpers here
end

before do
  @user = nil
end

get '/' do
  redirect '/login' unless logged_in?
  @user = HdUser.first(:email => current_user.email)
  if @user == nil
    @user = HdUser.new(:email => current_user.email)
    @user.save
  end
  haml :index
end
