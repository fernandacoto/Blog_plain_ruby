require 'fileutils'
module Blog
class Filehandler

  def save_post(title,comment)
    File.open("posts.txt", 'a+') do
    |f| f.write("Inicio de Post")
      	f.write("\n"+"Title:" + title + "\n" )
      	f.write( comment + "\n")
        f.write((Time.now).inspect + "\n")
      	f.write("Fin de Post" + "\n")
    end 
  end

  def get_posts_title
    titles=[]
    File.open("posts.txt",'r').each_line do |line|
      compare_line(line,titles)
    end
    return titles
  end

  def compare_line(line,titles)
    if line.include? "Title:"
      titles.push(line)
    end
  end

  def return_post(index)
    line= (index - 1)*5
    post = []
    post[0] = IO.readlines("posts.txt")[line + 1].to_s
    post[1] = IO.readlines("posts.txt")[line + 2].to_s
    post[2] = IO.readlines("posts.txt")[line + 3].to_s
    return post
  end

  def edit_post(index)
    final_post=[]
    post=return_post(index)
    final_post[0] = post[0].chomp
    final_post[1] = post[1].chomp
    final_post[2] = post[2].chomp
    return final_post
  end

  def delete_post(post_number)
    line_in_file = (post_number - 1) * 5
    in_line = 0
    line_counter= IO.readlines("posts.txt").count
    File.open('posts.txt.tmp','w') do |file2|
      while(line_counter >= in_line)
       if((in_line == line_in_file)||(in_line == (line_in_file + 1)) || (in_line == (line_in_file + 2)) || (in_line == (line_in_file + 3))|| (in_line == (line_in_file + 4)))
       else 
          file2.write(IO.readlines('posts.txt')[in_line].to_s)
       end
        in_line += 1
      end
    end
    FileUtils.mv 'posts.txt.tmp','posts.txt'
  end

end
end
