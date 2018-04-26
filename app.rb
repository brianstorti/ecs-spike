require 'sinatra'

set :bind, "0.0.0.0"

get "/" do
  "Hellow, world (v1)\n"
end
