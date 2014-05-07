require 'nokogiri'
require 'httparty'

class ImageImporter

end

file = File.open("../resources/imported_posts/2013-06.html")

html_doc = Nokogiri::HTML(file)
file.close

image_links = html_doc.css('img.image')
puts "Found #{image_links.size} for file #{File.basename(file)}"
image_links.each do |link|
  src = link["src"]
  filename = src.rpartition("/")[2]
  puts "Getting #{src}..."

  File.open("../resources/imported_images/#{filename}", "w") do |image_file|
    begin
      image_file << HTTParty.get(src)
      puts "Wrote image file #{File.basename(image_file)} to dir #{File.dirname(image_file)}"
    rescue SocketError
      puts "Couldn't get image, probably a network error."
    end

  end
end