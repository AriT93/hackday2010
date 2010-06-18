require "rubygems"
require "sinatra"
<<<<<<< HEAD
require "hackday.rb"
=======
>>>>>>> 0f0b9db6cee27a573f2b9e1ff456f9f0d69ccdbd
require "dm-core"
require "sinatra-authentication"
require "hackday"

<<<<<<< HEAD
set :environment, :devlopment
=======
>>>>>>> 0f0b9db6cee27a573f2b9e1ff456f9f0d69ccdbd

set :run, false
set :environment, :development

<<<<<<< HEAD
=======
FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

>>>>>>> 0f0b9db6cee27a573f2b9e1ff456f9f0d69ccdbd
run Sinatra::Application
