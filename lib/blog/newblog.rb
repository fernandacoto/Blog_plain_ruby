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
    return_main_page(res)
    if req.path_info == "/newpost"
       return_body_principal(res)
    elsif req.path_info == "/url"
      return_titles(res)
    elsif is_show_post?(req.path_info)
      is_show(req.path_info,res)
    elsif is_edit_post(req.path_info)
     edit_post(req.path_info,res)
    elsif is_delete_post?(req.path_info)
     delete_post(req.path_info,res)
    end
    res["content-type"] = "text/html"
  end

  def is_show_post?(path)
    clave ="Ver"
    if path.include? clave
      return true
    end
  end

  def is_show(path,response)
    position = path =~ /\d/
    if position != nil
      get_post_number(path,response,position)
      get_post_content(response,@post_number.to_i)
    end
  end

  def is_edit_post(path)
    clave ="editar"
    if path.include? clave
      return true
    end
  end

  def edit_post(path,response)
    position = path =~ /\d/
    if position != nil
      get_post_number(path,response,position)
      get_post_content_editable(response,@post_number.to_i)
    end
  end
  
  def get_post_content_editable(response,post_number)
    content = Filehandler.new()
    post = []
    post = content.edit_post(post_number)
    return response.body =<<-_end_of_html_
    <html>
    <body style= "background-color:#D1E0E0;">
         <h1 align = "center ">Edit post</h1>
	       <br><br>
	       <form method="POST" enctype="multipart/form-data">
                Title:    <input type="text" name="title" value ="#{post[0]}"><br>
                Comment:  <textarea type= "text" name ="comment">#{post[1]}</textarea><br>
               <input type="submit" /></form>
	       </form>
         <form method="POST" enctype="multipart/form-data">
	       <a href="url" name= "index" style="color:#E89C0C;">Index of posts</a><br>
         <a href="newpost" name="writepost" style="color:#E89C0C;">Write a new post</a><br>
         <a href="/" name="mainpage" style="color:#E89C0C;">Go to main page</a>
         </form>
    </body>
    </html>
      _end_of_html_
  end

  def get_post_number(path,response,position)
    if path.length == (position - 1)
      @post_number = path[position]
    else
      @post_number = is_more_than_a_digit(path,position)
    end
  end

  def is_more_than_a_digit(path,index)
    post = ""
    while path.length > index
      post << path[index]
      index += 1
    end
    return post.to_i
  end

  def get_post_content(response,post_number)
    content = Filehandler.new()
    post = []
    post = content.return_post(post_number)
    return response.body =<<-_end_of_html_
      <html>
      <body style= "background-color:#D1E0E0;">
      <h1>Showing post number #{post_number}</h1>
      <h2> #{post[0]}</h2>
      <p>Comment: #{post[1] + "\n"}</p>
      <p>Date/time: #{post[2]}</p>
      <br>
      <br>
      <form method="POST" enctype="multipart/form-data">
	      <a href="url" name= "index" style="color:#E89C0C;">Index of posts</a><br>
        <a href="newpost" name= "writepost" style="color:#E89C0C;">Write a new post</a><br>
        <a href="/" name= "mainpage" style="color:#E89C0C;">Go to main page</a>
      </form>
      </body>
      </html>
      _end_of_html_
  end

  def is_delete_post?(path)
    clave ="eliminar"
    if path.include? clave
      return true
    end
  end

  def delete_post(path,response)
    position = path =~ /\d/
    if position != nil
      get_post_number(path,response,position)
      action = Filehandler.new()
      action.delete_post(@post_number)
    end
  end

  def do_POST(req, res)
    do_GET(req, res)
    escribir = Filehandler.new()
    escribir.save_post(@title,@comment)
    res.body =<<-_end_of_html_
    <html>
    <body style= "background-image:url('http://learn-rails.com/images/ruby.png');background-color:#D1E0E0;background-repeat:no-repeat;background-position:450px 100px;background-size:100px 100px; ">
         <h1 align = "center " style="color:#007A7A;">Blog in plain ruby using webrick</h1>
	       <br><br>
         <div>
         <h2 style="color:#009999;">Menu</h2>
         </div>
         <form method="POST" enctype="multipart/form-data">
         <a href = "newpost" name = "writepost" style="color:#E89C0C;">Write a new post</a><br>
	       <a href="url" name= "index" style="color:#E89C0C;">Index of posts</a>
         </form>
    </body>
    </html>
    _end_of_html_
    if (req.path_info).include? "editar"
       delete_post(req.path_info,res)
    end
  end

  def return_body_principal(res)
    return res.body =<<-_end_of_html_
    <html>
    <body style= "background-color:#D1E0E0;">
         <h1 align = "center ">Blog in plain ruby using webrick</h1>
	       <br><br>
	       <form method="POST" enctype="multipart/form-data">
                Title:    <input type="text" name="title"><br>
                Comment:  <textarea type= "text" name ="comment"></textarea><br>
               <input type="submit" /></form>
	       </form>
         <form method="POST" enctype="multipart/form-data">
	       <a href="url" name= "index" style="color:#E89C0C;">Index of posts</a><br>
         <a href = "/" name = "main_page" style="color:#E89C0C;">Go to Main Page</a>
         </form>
    </body>
    </html>
    _end_of_html_
  end 

  def return_titles(res)
    titles = Filehandler.new()
    return res.body =<<-_end_of_html_
    <html>
    <body style= "background-color:#D1E0E0;">
    <h1>List of Post's</h1>
    #{make_links(titles.get_posts_title)}
    <a href="newpost" name="writepost" style="color:#E89C0C;">Write a new post</a><br>
    <a href="/" name="mainpage" style="color:#E89C0C;">Go to main page</a>
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
      list<<"<li><a href=#{"Ver" + post} style=color:#E89C0C; name=#{element}>#{element}</a><ul><li><a href=#{"eliminar"+ post} style=color:#440CE8;>Eliminar</a></li><li><a href=#{"editar"+ post} style=color:#440CE8;>Editar</a></li></ul></li>"
      index +=1
    end
    list<<"</ul>"
    return list
  end

 def return_main_page(res)
    return res.body =<<-_end_of_html_
    <html>
    <body style= "background-image:url('http://learn-rails.com/images/ruby.png');background-color:#D1E0E0;background-repeat:no-repeat;background-position:450px 100px;background-size:100px 100px; ">
         <h1 align = "center " style="color:#007A7A;">Blog in plain ruby using webrick</h1>
	       <br><br>
         <div>
         <h2 style="color:#009999;">Menu</h2>
         </div>
         <form method="POST" enctype="multipart/form-data">
         <a href = "newpost" name = "writepost" style="color:#E89C0C;">Write a new post</a><br>
	       <a href="url" name= "index" style="color:#E89C0C;">Index of posts</a>
         </form>
    </body>
    </html>
    _end_of_html_
 end

end

svr = WEBrick::HTTPServer.new(:Port=>10080)
svr.mount("/", PostSampleServlet, 100000)
  trap(:INT){ svr.shutdown }
  svr.start
end
