module Blog
require "webrick"
require './Filehandler.rb'

class PostSampleServlet < WEBrick::HTTPServlet::AbstractServlet
  
  def initialize(server, limit)
    @max_content_length = limit
    super
  end

  def do_GET(req, res)
    @title = req.query["title"]
    @comment = req.query["comment"]
    @prueba= ":D"
    return_body_principal(res)
    if req.path_info == "/url"
      return_titles(res)
    end
    is_title?(req.path_info, res)
    res["content-type"] = "text/html"
  end

  def is_title?(extension, res)
    array = extension.split("/")
    post = Filehandler.new()
    print "POST A BUSCAR"
    print array[1]
    print post.return_post(array[1].to_i)
  end

  def do_POST(req, res)
    do_GET(req, res)
    escribir = Filehandler.new()
    escribir.save_post(@title,@comment)
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
	       <a href="url" name= "index">Index</a>
         </form>
    </html>
    _end_of_html_
  end 

  def return_prueba(res)
    return res.body =<<-_end_of_html_
      <html>
      <body>
      <h1>INDEX</h1>
      #{@prueba}
      </body>
      </html>
      _end_of_html_
  end

  def return_titles(res)
    titles = Filehandler.new()
    return res.body =<<-_end_of_html_
    <html>
    <body>
    <h1>List of Post's</h1>
    #{make_links(titles.get_posts_title)}
    </body>
    </html>
    _end_of_html_
  end

  def make_links(titles)
    index = 1
    list = "<ul>"
    titles.each do 
      |element|
      post = ""
      post<<index.to_s
      list<<"<li><a href=#{post} name=#{element}>#{element}</a><ul><li><a href=#{"eliminar"+ post}>Eliminar</a></li><li><a href=#{"editar"+ post}>Editar</a></li></ul></li>"
      index +=1
    end
    list<<"</ul>"
    return list
  end

end

svr = WEBrick::HTTPServer.new(:Port=>10080)
svr.mount("/", PostSampleServlet, 100000)
trap(:INT){ svr.shutdown }
svr.start
end
