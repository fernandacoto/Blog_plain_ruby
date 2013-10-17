require 'spec_helper'
module Blog
  FILE_ROUTE = './posts.txt'
  COMMENT_TEST = "Testing comment" 
  TITLE_TEST = "Testin' titles"
  describe Filehandler do
    before(:all) do
      $new_post_test = Filehandler.new()
    end
    describe "#writes a new post in a blank file" do
      it "check that the new post was written verifying that in the second line the title is the same as the one introduced" do
       $new_post_test.save_post(TITLE_TEST,COMMENT_TEST)
       expect(IO.readlines(FILE_ROUTE)[1].to_s.chomp).to eq("Title:" + TITLE_TEST)
      end
    end
    describe "#returns a specified post number" do
      it "should show all the details about the post" do
	      #result = post.return_post(1)
        #result[0].should == "Title:titulo\n"
      end
    end
    describe "#edit#" do
      it "should update a post"
    end
    describe "#delete#" do
      it "should delete a post" do
      #d = Filehandler.new()
      #d.delete_post(2)
      #line_counter2= IO.readlines('./posts.txt').count
      #line_counter2.should == 5
    end
    end
  end
end


