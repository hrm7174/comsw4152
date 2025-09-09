require 'sinatra/base'

class MyApp < Sinatra::Base
  # allow any host in dev so Rack host protection doesn't block Codio
  set :host_authorization, { permitted_hosts: [] }

  get '/' do
    '<!DOCTYPE html><html><body><h1>Goodbye World</h1></body></html>'
  end
end
