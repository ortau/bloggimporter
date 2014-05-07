#!/usr/bin/env ruby
require_relative '../lib/blog_importer'

first = ARGV.shift
second = ARGV.shift
first == nil ? years = BlogImporter.blog_years : years = first.split(' ')
second == nil ? months = BlogImporter.all_months : months = second.split(' ')

importer = BlogImporter.new(years, months)
importer.save_blog_entries