set :stages, %w[local ri ga ct]
set :default_stage, "local"

require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :application, "dashboard"

set :repository, "git://github.com/mission-of-mercy/momma_dashboard.git"
set :deploy_via, :remote_cache

set :scm, :git
set :user, "deploy"

set :deploy_to, "/home/deploy/#{application}"
set :use_sudo, false

after 'deploy:update_code' do
  { "mom.yml"         => "config/mom.yml",
    "log"             => "log" }.
   each do |from, to|
     run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
   end
end

after "deploy", "deploy:cleanup"

after "deploy" do
  run "sudo restart dashboard"
end
