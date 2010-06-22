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
  if current_user
    redirect "/users/#{current_user.id}/edit" unless current_user.email
  end
  @user = HdUser.first(:email => current_user.email)
  if @user == nil
    @user = HdUser.new(:email => current_user.email)
    @user.save
  end
  haml :index
end

get '/css/style.css' do
  content_type 'text/css'
  sass :style
end

get '/logout' do
  haml "= render_login_logout"
end
