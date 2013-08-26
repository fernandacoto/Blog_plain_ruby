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
    prueba= ":D"
    return_body_principal(res)
    if req.path_info == "/url"
      res.body =<<-_end_of_html_
      <html>
      <body>
      <h1>INDEX</h1>
      #{prueba}
      </body>
      </html>
      _end_of_html_
    end
    res["content-type"] = "text/html"
  end
  
  def do_POST(req, res)
    do_GET(req, res)
    save_post
  end

  def return_body_principal(res)
    return res.body =<<-_end_of_html_
    <html>
         <h1 align = "center ">Blog in plain ruby using webrick</h1>
	       <br><br>
	       <form method="POST" enctype="multipart/form-data">
                Title:    <input type="text" name="title"><br>
                Comment:  <textarea type= "text" name ="comment"></textarea><br>
               <input type="submit" /></form>
	       </form>
         <form method="POST" enctyoe="multipart/form-data">
	       <button type="button" name= "show_all_posts">Show all posts</button>
	       <a href="url" name= "index">Index</a>
         </form>
    </html>
    _end_of_html_
  end

  def save_post
    File.open("posts.txt", 'a+') do
    |f| f.write("*-*-*-*-*-*-*")
      	f.write("\n" + "Title:" + @title + "\n" )
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
