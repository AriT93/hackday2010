set :application, "hackday2010"
set :repository,  "git@github.com:AriT93/hackday2010.git"
set :deploy_to, "/home/hackday"
set :user, "abturet"

set :use_sudo, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "hackday.turetzky.org"                          # Your HTTP server, Apache/etc
role :app, "hackday.turetzky.org"                          # This may be the same as your `Web` server
role :db,  "hackday.turetzky.org", :primary => true # This is where Rails migrations will run
role :db,  "hackday.turetzky.org"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "#{try_sudo} ln -s /home/hackday/facebooker.yml /home/hackday/current/facebooker.yml"
    run "#{try_sudo} ln -s /home/hackday/development.db /home/hackday/current/production.db"
  end
end
