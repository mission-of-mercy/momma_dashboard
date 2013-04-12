require 'dashing'

configure do
  set :auth_token, ENV['DASHBOARD_AUTH_TOKEN']
  set :default_dashboard, 'general'

  settings.sprockets.append_path 'assets/mp3'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
