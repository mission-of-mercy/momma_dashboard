server "momma.ga", :app, :web, :db, :primary => true

after 'deploy:update_code' do
  run "ln -nfs #{shared_path}/logo.png #{release_path}/assets/images/logo.png"
end
