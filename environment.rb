require 'rubygems'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'digest/sha1'
require 'dm-migrations'
require 'haml'
require 'ostruct'

require 'sinbook'
require 'sinatra' unless defined?(Sinatra)
require 'sinatra-authentication'

configure do
  SiteConfig = OpenStruct.new(
                 :title => 'hackday 2010',
                 :author => 'Paul Iutzi, Ari Turetzky',
                 :url_base => 'http://localhost:4567/'
               )

  # load models
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }


  DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3://#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db"))

  if File.exist?("facebooker.yml")
    env=:production
    @@yaml = YAML.load_file("facebooker.yml")[env.to_s]
    facebook do
      api_key @@yaml['api_key']
      secret @@yaml['secret_key']
      app_id @@yaml['app_id']
      url @@yaml['canvas_page_name']
      callback @@yaml['callback_url']
      symbolize_keys true
    end
  end
end
