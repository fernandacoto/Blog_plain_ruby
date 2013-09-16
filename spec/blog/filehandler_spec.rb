require 'spec_helper'
module Blog
  describe Filehandler do
    describe "#writes a post" do
      it "writes a new post in file" do
       post = Filehandler.new()
       post.save_post("titulo","comentario")
       line_counter2= IO.readlines('./posts.txt').count
       line_counter2.should == 10
      end
    end
    describe "#returns a specified post number" do
      it "should show all the details about the post" do
        post = Filehandler.new()
	result = post.return_post(1)
        result[0].should == "Title:titulo\n"
      end
    end
    describe "#edit#" do
      it "should update a post"
    end
    describe "#delete#" do
      it "should delete a post" do
      d = Filehandler.new()
      d.delete_post(2)
      line_counter2= IO.readlines('./posts.txt').count
      line_counter2.should == 5
    end
    end
  end
end


