require 'rubygems'
require 'sinatra'
require 'hackday.rb'
require 'dm-core'
require 'sinatra-authentication'
require 'sass'
require 'hackday'


set :run, false
set :environment, :development
disable :logging

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application
