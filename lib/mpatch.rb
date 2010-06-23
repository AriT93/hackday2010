require 'sinatra/base'

module Sinatra
  module LilAuthentication
    def self.registered(app)
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

    end
  end
end
