require 'rubygems'
require 'sinatra'

before do
  response['Access-Control-Allow-Headers'] = '*, pragma, cache-control, x-stream, accept, If-Modified-Since, X-Ajax-Browser-Auth'
  response['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
  response['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN']
end

options '*' do
  200
end

get '/:file' do |file|
  send_file File.join("html", file)
end