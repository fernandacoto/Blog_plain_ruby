module Blog
require "webrick"
#require './htmls.rb'
#require './Filehandler.rb'
require Dir.pwd+'/lib/blog/htmls.rb'
require Dir.pwd+'/lib/blog/Filehandler.rb'
class PostSampleServlet < WEBrick::HTTPServlet::AbstractServlet
  
  #def initialize(server, limit)
  #  @max_content_length = limit
  #  super
  #end

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
    if path.include? "Ver"
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
    if path.include? "editar"
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
    html = Htmls.new()
    post = []
    post = content.edit_post(post_number)
    return response.body =<<-_end_of_html_
          #{html.edit_one}
          Title:    <input type="text" name="title" value ="#{post[0]}"><br>
          Comment:  <textarea type= "text" name ="comment">#{post[1]}</textarea><br>
          #{html.edit_two}
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
    html = Htmls.new()
    post = []
    post = content.return_post(post_number)
    return response.body =<<-_end_of_html_
      <html><body style= "background-color:#D1E0E0;"><h1>Showing post number #{post_number}</h1>
      <h2> #{post[0]}</h2><p>Comment: #{post[1] + "\n"}</p><p>Date/time: #{post[2]}</p><br><br>
      #{html.menu}
      _end_of_html_
  end

  def is_delete_post?(path)
    if path.include? "eliminar"
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
    html = Htmls.new()
    res.body = html.main_page
    really_needs_detele?(res,req)
  end

  def really_needs_detele?(res,req)
    if (req.path_info).include? "editar"
       delete_post(req.path_info,res)
    end
  end

  def return_body_principal(res)
    html = Htmls.new()
    return res.body = html.write_post
  end 

  def return_titles(res)
    html = Htmls.new()
    titles = Filehandler.new()
    return res.body =<<-_end_of_html_
      #{html.index_of_post_one}#{make_links(titles.get_posts_title)}#{html.index_of_post_two} 
                        _end_of_html_
  end

  def make_links(titles)
    index = 1
    list = "<ul>"
    titles.each do 
      |element|
      post = ""
      post<<index.to_s
      list<<"<li><a href=#{"Ver" + post} style=color:#E89C0C;>#{element}</a><ul><li><a href=#{"eliminar"+ post} style=color:#440CE8;>Eliminar</a></li><li><a href=#{"editar"+ post} style=color:#440CE8;>Editar</a></li></ul></li>"
      index +=1
    end
    list<<"</ul>"
    return list
  end

 def return_main_page(res)
    html = Htmls.new()
    return res.body =html.main_page
 end

end

#svr = WEBrick::HTTPServer.new(:Port=>10080)
#svr.mount("/", PostSampleServlet, 100000)
#  trap(:INT){ svr.shutdown }
#  svr.start
end
