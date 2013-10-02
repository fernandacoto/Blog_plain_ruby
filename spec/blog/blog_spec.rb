module Blog
require Dir.pwd+'/spec/spec_helper'
require 'webrick'
describe PostSampleServlet do
    describe "#post" do
      it "waits for title and a comment" do
        query = {title: "Test title",commment: "Testing comment"}
        res = {}
        initialize_test_server(1)
        blog = PostSampleServlet.new(initialize_test_server(1))
        blog.do_POST(query, res)
        initialize_test_server(2)
      end
    end
    describe "#see#" do
      it "should show all posts"
    end
    describe "#edit#" do
      it "should update a post"
    end
    describe "#delete#" do
      it "should delete a post"
    end
def initialize_test_server(number)
  start = 1
  @test_thread_server = Thread.new{
    if start == number
      @svr = WEBrick::HTTPServer.new(:Port=>10080)
      @svr.mount("/",PostSampleServlet,100000)
      @svr.start 
    else
      @svr.shutdown
      stop_test_server
    end
  }
end
def stop_test_server
    Thread.kill(@test_thread_server)
end
end
end
