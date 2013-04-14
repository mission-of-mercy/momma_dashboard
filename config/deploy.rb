require 'bundler/capistrano'

set :application, "dashboard"

set :repository, "git://github.com/mission-of-mercy/momma_dashboard.git"
set :deploy_via, :remote_cache

set :scm, :git
set :user, "deploy"

set :deploy_to, "/home/deploy/#{application}"
set :use_sudo, false

server "172.16.58.128", :app, :web, :db, :primary => true

after 'deploy:update_code' do
  { "mom.yml"         => "config/mom.yml" }.
   each do |from, to|
     run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
   end
end

after "deploy", "deploy:cleanup"

after "deploy" do
  run "touch #{File.join(current_path,'tmp','restart.txt')}"
end
