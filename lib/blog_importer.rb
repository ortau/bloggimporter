require 'rubygems'
require 'httparty'

class BlogImporter
  include HTTParty
  base_uri "http://hannacecilia.blogg.se"
  attr_accessor :years
  attr_accessor :months

  def initialize(years = blog_years, months = all_months)
    @years = years
    @months = months
  end

  def save_blog_entries
    puts("IMPORTING #{@years} AND MONTHS #{@months})")
    @years.each do |year|
      save_entries_for_year year
    end
  end

  def save_entries_for_year(year)
    @months.each do |month|
      month_no = (BlogImporter.all_months.find_index month) + 1
      response = BlogImporter.get("/#{year}/#{month}/")
      save_entry response, "#{year}-#{month_no.to_s.rjust(2, '0')}.html"
    end
  end

  def save_entry(response, filename="entry.html")
    puts "Writing blog entries: #{filename}"
    File.open("../resources/imported_posts/#{filename}", "w") do |file|
      file.puts response.to_s
    end
  end

  def self.all_months
    names = []
    Date::MONTHNAMES.each {|d| names << d.to_s.downcase unless d == nil}
    return names
  end

  def self.blog_years
    ["2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013"]
  end
end