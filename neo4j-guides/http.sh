PORT=${1-8001}
gem install --no-ri --no-rdoc sinatra
ruby http.rb -p $PORT