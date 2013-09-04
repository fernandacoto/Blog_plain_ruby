require 'fileutils'
class Filehandler

  def save_post(title,comment)
    File.open("posts.txt", 'a+') do
    |f| f.write("Inicio de Post")
      	f.write("\n" + "Title:" + title + "\n" )
      	f.write("Comment:" + comment + "\n")
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
    post = ""
    post<< IO.readlines("posts.txt")[line + 1].to_s
    post<< IO.readlines("posts.txt")[line + 2].to_s
    post<< IO.readlines("posts.txt")[line + 3].to_s
    return post
  end

  def delete_post(postnumber)
    line_in_file = (postnumber - 1) * 5
    File.open('posts.txt','r') do |file|
      File.open('posts.txt.tmp','w') do |file2|
        file.each_line do |line|
          file2.write(line) unless ((line == (IO.readlines("posts.txt")[line_in_file - 1].to_s))||(line == (IO.readlines("posts.txt")[line_in_file + 1].to_s))|| (line == (IO.readlines("posts.txt")[line_in_file + 2].to_s)) || (line == (IO.readlines("posts.txt")[line_in_file + 3].to_s)) || (line == (IO.readlines("posts.txt")[line_in_file + 4])))
        end
      end 
    end
    FileUtils.mv 'posts.txt.tmp','posts.txt'
  end
  def delete(post_number)
    line_in_file = (post_number - 1) * 5
    in_line = 6
    line_counter= IO.readlines("posts.txt").count
    File.open('posts.txt.tmp','w') do |file2|
      while(line_counter >= in_line) 
        file2.write(IO.readlines('posts.txt')[in_line].to_s)
        print IO.readlines('posts.txt')[in_line].to_s
        print "\n"
        print in_line
        print "\n"
        in_line += 1
      end
    end
    FileUtils.mv 'posts.txt.tmp','posts.txt'
  end

  #def print_array(titles)
  #  index = 1
  #  print "Print array"
  #  titles.each do&& (line_counter != (line_in_file - 1)) && (line_counter != (line_in_file + 1)) && (line_counter != (line_in_file + 2)) && (line_counter != (line_in_file + 3)) && (line_counter != (line_in_file + 4)))
  #  sts_title
  #
  #    |element|
  #    print element + "element\n"
  #    print index 
  #    print "index\n"
  #    index +=1
  #  end
  #  print "END"
  #end
end

prueba = Filehandler.new()
#prueba.return_post(2)
prueba.delete(3)
