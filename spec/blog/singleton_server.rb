require 'webrick'
require 'singleton'
require Dir.pwd+'/spec/spec_helper'
require Dir.pwd+'/lib/blog/Filehandler.rb'
class Server
  include Singleton
  attr :server
  def initialize_test_server
    @server = WEBrick::HTTPServer.new(:Port=>3001, :DocumentRoot=> "./")
    @server.mount("/",Blog::PostSampleServlet)
    @server.start
  end

  def stop_test_server
    @server.shutdown
  end
end
