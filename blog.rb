require 'erb'
require 'webrick'
require 'yaml'

ROOT = File.dirname(__FILE__)

server = WEBrick::HTTPServer.new(:Port => 8000, :DocumentRoot => "#{ROOT}/public")

server.mount_proc '/post' do |req, res|
  @page_title = "Amie's Blog."
  @blog = File.read("#{ROOT}/post.yml").split("\n")
  template = ERB.new(File.read("#{ROOT}/index.html.erb"))
  res.body = template.result
end

# server.mount_proc '/movies' do |req, res|
#   @page_title = "Movies."
#   @ice_cream = File.read("#{ROOT}/movies.txt").split("\n")
#   template = ERB.new(File.read("#{ROOT}/index.html.erb"))
#   res.body = template.result
# end

trap 'INT' do
  server.shutdown
end

server.start
