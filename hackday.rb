require "rubygems"
require 'environment'
require 'sinbook'
require 'sinatra'
require 'dm-core'
require 'digest/sha1'
require 'sinatra-authentication'
require 'haml'
require 'sass'
require 'rack-flash'
require 'pp'
require 'mini_fb'
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
  if !current_user.email
    current_user.destroy!
    flash[:notice] ="You need to login or create an account first then link it to your Facebook account"
    session[:user] = nil
    redirect '/login'
  else
    @user = HdUser.first(:email => current_user.email)
    if @user == nil
      @user = HdUser.new(:email => current_user.email)
      @user.save
    end

    @oauth_url = MiniFB.oauth_url(123673737674492,"http://hackday.turetzky.org/sessions/create",:scope=>MiniFB.scopes.join(","))

    haml :index
  end
end

get '/sessions/create' do
  access_token_hash = MiniFB.oauth_access_token(123673737674492,"http://hackday.turetzky.org/sessions/create",'ca85c1a9f608e112de2eb97e7cee67e5', params[:code])
  @access_token = access_token_hash["acess_token"]
  cookies[:access_token] = @access_token
end

get '/css/style.css' do
  content_type 'text/css'
  sass :style
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
