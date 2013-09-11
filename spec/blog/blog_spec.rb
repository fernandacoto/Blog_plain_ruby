require 'spec_helper'
require 'webrick'
require Blog
  describe Blog::PostSampleServlet do
    before(:each) do
     @server=Thread.new do
        svr = WEBrick::HTTPServer.new(:Port=>10080)
        svr.mount("/",PostSampleServlet,100000)
        svr.start
     end
    end
    after(:each) do
      @server.shutdown
    end
    describe "#post" do
      it "waits for title and a comment" do
        #svr = WEBrick::HTTPServer.new(:Port=>10080)
        #svr.mount("/",PostSampleServlet, 100000)
        #trap(:INT){ svr.shutdown }
        #svr.start
        @server.join
        post "http://localhost:10080/"
        status.should.equal 200
        #res.code.should == 200
        svr.shutdown
        # save_post
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
  end


