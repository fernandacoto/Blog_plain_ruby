module Blog
require "webrick"

class PostSampleServlet < WEBrick::HTTPServlet::AbstractServlet
  
  def initialize(server, limit)
    @max_content_length = limit
    super
  end

  def do_GET(req, res)
    @title = req.query["title"]
    @comment = req.query["comment"]
    return_body_principal(res)
    res["content-type"] = "text/html"
  end
  
  def do_POST(req, res)
    do_GET(req, res)
    save_post
  end

  def return_body_principal(res)
    return res.body =<<-_end_of_html_
    <html>
         <h1>Blog in plain ruby using webrick</h1>
	       <br><br>
	       <form method="POST" enctype="multipart/form-data">
                Title:    <input type="text" name="title"><br>
                Comment:  <textarea type= "text" name ="comment"></textarea><br>
               <input type="submit" /></form>
	       </form>
         <form method="POST" enctyoe="multipart/form-data">
	       <button type="button" name= "show_all_posts">Show all posts</button>
	       <button type="button" name= "index">Index</button>
         </form>
    </html>
    _end_of_html_
  end

  def save_post
    File.open("posts.txt", 'a+') do
    |f| f.write("*-*-*-*-*-*-*")
      	f.write("\n" +"Title:" + @title + "\n" )
      	f.write("Comment:" + @comment + "\n")
        f.write((Time.now).inspect + "\n")
      	f.write("*-*-*-*-*-*-*" + "\n")
    end  
  end
end

svr = WEBrick::HTTPServer.new(:Port=>10080)
svr.mount("/", PostSampleServlet, 100000)
trap(:INT){ svr.shutdown }
svr.start
end
