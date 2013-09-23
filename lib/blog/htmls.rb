module Blog
class Htmls
def initialize
  @main_page=<<-_end_of_html_
    <html><body style= "background-image:url('http://learn-rails.com/images/ruby.png');backgroundcolor:#D1E0E0;background-repeat:no-repeat;background-position:450px 100px;background-size:100px 100px; ">
	 <h1 align = "center " style="color:#007A7A;">Blog in plain ruby using webrick</h1><br><br>
	 <h2 style="color:#009999;">Menu</h2>
	 <form method="POST" enctype="multipart/form-data">
	 <a href = "newpost" name = "writepost" style="color:#E89C0C;">Write a new post</a><br>
	 <a href="url" name= "index" style="color:#E89C0C;">Index of posts</a>
	 </form></body></html>
    _end_of_html_
  @index_one = <<-_end_of_html_
    <html><body style= "background-color:#D1E0E0;">
    <h1>List of Post's</h1>
    _end_of_html_
  @index_two = <<-_end_of_html_
    <a href="newpost" name="writepost" style="color:#E89C0C;">Write a new post</a><br>
    <a href="/" name="mainpage" style="color:#E89C0C;">Go to main page</a>
    </body>
    </html>
  _end_of_html_
  @new_post =<<-_end_of_html_
    <html><body style= "background-color:#D1E0E0;">
         <h1 align = "center ">Blog in plain ruby using webrick</h1><br><br>
	       <form method="POST" enctype="multipart/form-data">
                Title:    <input type="text" name="title"><br>
                Comment:  <textarea type= "text" name ="comment"></textarea><br>
               <input type="submit" /></form>
         <form method="POST" enctype="multipart/form-data">
	 <a href="url" name= "index" style="color:#E89C0C;">Index of posts</a><br>
         <a href = "/" name = "main_page" style="color:#E89C0C;">Go to Main Page</a>
         </form></body></html>
    _end_of_html_
  @menu = <<-_end_of_html_
       <form method="POST" enctype="multipart/form-data">
	<a href="url" name= "index" style="color:#E89C0C;">Index of posts</a><br>
        <a href="newpost" name= "writepost" style="color:#E89C0C;">Write a new post</a><br>
        <a href="/" name= "mainpage" style="color:#E89C0C;">Go to main page</a>
      </form></body></html>
            _end_of_html_
  @edit_one = <<-_end_of_html_
	 <html><body style= "background-color:#D1E0E0;">
         <h1 align = "center ">Edit post</h1><br><br>
         <form method="POST" enctype="multipart/form-data">
                 _end_of_html_
  @edit_two= <<-_end_of_html_
	 <input type="submit" /></form>
         <form method="POST" enctype="multipart/form-data">
	 <a href="url" name= "index" style="color:#E89C0C;">Index of posts</a><br>
         <a href="newpost" name="writepost" style="color:#E89C0C;">Write a new post</a><br>
         <a href="/" name="mainpage" style="color:#E89C0C;">Go to main page</a>
         </form></body></html> 
                 _end_of_html_
end

def main_page
  return @main_page
end
def index_of_post_one
  return @index_one
end
def index_of_post_two
  return @index_two
end
def write_post
  return @new_post
end
def menu
  return @menu
end
def edit_one
  return @edit_one
end
def edit_two
  return @edit_two
end
end
end
