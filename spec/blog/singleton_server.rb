require 'webrick'
require 'singleton'
require Dir.pwd+'/spec/spec_helper'
require Dir.pwd+'/lib/blog/newblog.rb'
class Server
  include Singleton
  attr :server
  def initialize_test_server
    @server = WEBrick::HTTPServer.new(:Port=>10080)
    @server.mount("/",PostSampleServlet,100000)
    @server.start
  end

  def stop_test_server
    begin
      @server.shutdown
    rescue
    end
  end
end
