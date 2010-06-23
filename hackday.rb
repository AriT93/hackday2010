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

set :sinatra_authentication_view_path, Pathname(__FILE__).dirname.expand_path + "views/"


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
  def fb2hd
    if fb[:user]
      @email = DmUser.first(:fb_uid => fb[:user].to_s)
      @user = HdUser.first(:email => @email.email)
    end
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
  if fb[:name] and @user.name == ""
    @user.name = fb[:name]
  end
  haml :index
end

get '/css/style.css' do
  content_type 'text/css'
  sass :style
end

get '/connect' do
  redirect 'http://cnn.com'
  if fb[:user]
    if current_user.class != GuestUser
      user = current_user
    else
#      user = User.get(:fb_uid => fb[:user])
    end

    if user != nil
      if !user.fb_uid || user.fb_uid != fb[:user]
#        user.update :fb_uid => fb[:user]
      end
      session[:user] = user.id
    else
      user = User.set!(:fb_uid => fb[:user])
#      session[:user] = user.id
      flash[:notice] ="You need to login or create an account first then link it to your Facebook account"
      redirect '/login'
    end
  end
  redirect '/'
end

get '/login' do
  haml :login
end

get 'signup' do
  haml :signup
end

get '/logout' do
  haml "= render_login_logout"
end

get '/canvas/' do
  if fb[:user]
    @email = DmUser.first(:fb_uid => fb[:user].to_s)
    @user = HdUser.first(:email => @email.email)
  end
  haml :fbook2, :layout => false
end

get '/canvas/fbaccounts' do
  fb2hd
  haml :fbaccounts,:layout => false
end

get '/canvas/fbmessages' do
  fb2hd
  haml :fbmessages, :layout => false
end

get '/canvas/fbclaims' do
  fb2hd
  haml :fbclaims, :layout => false
end

get '/canvas/fbpolicies' do
  fb2hd
  haml :fbpolicies, :layout => false
end
