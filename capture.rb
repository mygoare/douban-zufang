#!/usr/bin/env ruby

require "open-uri"
require "uri"

douban_url = URI.escape("http://www.douban.com/group/search?group=146409&cat=1013&q=静安")
t = Time.now

open(douban_url) { |f|
  content = f.read()
  links = content.scan(/<tr class=\"pl\">[\s\S]*?<\/tr>/).flatten

  links = links.select { |link| link =~ (Regexp.new t.strftime("%Y-%m-%d")) }

  puts links
}
