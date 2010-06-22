require "rubygems"
require 'environment'
require 'sinatra'
require 'dm-core'
require 'digest/sha1'
require 'sinbook'
require 'sinatra-authentication'
require 'haml'
require 'sass'
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
  def partial(name, options={})
    haml("_#{name.to_s}".to_sym, options.merge(:layout => false))
  end
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

get '/receiver' do
  %[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" >
  <body>
      <script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/XdCommReceiver.js" type="text/javascript"></script>
  </body>
  </html>]
end
get '/css/style.css' do
  content_type 'text/css'
  sass :style
end
