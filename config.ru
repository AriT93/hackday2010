require "rubygems"
require "sinatra"
require "hackday.rb"
require "dm-core"
require "sinatra-authentication"
require "sass"
require "hackday"


set :run, false
set :environment, :development
disable :logging

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

use Rack::FacebookConnect '3a36c731cffc23da5c477ccd07a30c50','ca85c1a9f608e112de2eb97e7cee67e5'
run Sinatra::Application
