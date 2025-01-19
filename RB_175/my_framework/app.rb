require 'rack'

require_relative 'monroe.rb'
require_relative 'advice.rb'

class App
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      status = '200'
      headers = {"Content-Type" => 'text/html'}
      Monroe.new.response(status, headers) do
        Monroe.new.erb :index
      end
    when '/advice'
      piece_of_advice = Advice.new.generate
      status = '200'
      headers = {"Content-Type" => 'text/html'}
      Monroe.new.response(status, headers) do
        Monroe.new.erb :advice, message: piece_of_advice
      end
    else
      status = '404'
      headers = {"Content-Type" => 'text/html', "Content-Length" => '58'}
      Monroe.new.response(status, headers) do
        Monroe.new.erb :not_found
      end
    end
  end
end
