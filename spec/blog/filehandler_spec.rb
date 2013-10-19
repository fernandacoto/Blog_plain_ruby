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
      it "asking for the first post it has to return the title of that post number" do
        post_content = $new_post_test.return_post(1)
        expect(post_content[0].chomp).to eq("Title:" + TITLE_TEST)
      end
    end
    describe "#get_posts_title" do
      it "after writing a post when calling get_post_title has to return an array with size 1" do 
        titles = $new_post_test.get_posts_title
        expect(titles.length).to eq(1)
      end
    end
    describe "#delete" do
      it "deletes the first post number, the file after that has 0 lines of text" do
        $new_post_test.delete_post(1)
        expect(IO.readlines(FILE_ROUTE).count).to eq(0)
      end
    end
  end
end


