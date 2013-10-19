require Dir.pwd+'/spec/spec_helper'
require Dir.pwd+'/spec/blog/singleton_server.rb'
require 'net/http'
require 'webrick'
require 'open-uri'
module Blog
describe PostSampleServlet do
  before(:all) do
    @server = Server.instance
    Thread.new {
      @server.initialize_test_server }
  end
  after(:all) do
    @server.stop_test_server
  end
  describe "#post" do
      it "waits for title and a comment" do
        print Net::HTTP.get_response('localhost',"/",10080)
        #Net::HTTP.start('http://localhost:10080') { |http| print http.get('/') }
        #Net::HTTP.get('127.0.0.1',"/index",10080)
        #res = Net::HTTP.get_response('http://localhost:10080/index')
        #print res.body
      end
    end
  describe "#see" do
    it "shows all posts"
  end
  describe "#edit" do
    it "updates a post"
  end
  describe "#delete" do
    it "deletes a post"
  end

  #def initialize_test_server
  #   @test_thread_server = Thread.new{
  #   @server.initialize_test_server }
  #end

  #def stop_test_server
  #  begin
  #    @server.stop_test_server
  #    Thread.kill(@test_thread_server)
  #  rescue
  #  end
  #end

end
end
