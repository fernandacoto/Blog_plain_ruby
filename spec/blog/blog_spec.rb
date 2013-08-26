require 'spec_helper'
module Blog
  describe Blog do
    describe "#post" do
      it "waits for title and a comment" do
        @tilte = "testing"
        @comment = "testing"
        save_post
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

