require 'spec_helper'
module Blog
  describe Blog do
    describe "#post" do
      it "waits for title and a comment" do
        @tilte = "testing"
        @comment = "testing"
        svr = WEBrick::HTTPServer.new(:Port=>10080)
        svr.mount("/", PostSampleServlet, 100000)
        #trap(:INT){ svr.shutdown }
        svr.start
        get :get_event, {:title => "TITULO 1", :comment => "Comment" }
        response.code.should == 200
        svr.shutdown
        #srv.shoutdown
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
end

