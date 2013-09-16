# encoding: utf-8

require "open-uri"
require "uri"

douban_url = URI.escape("http://www.douban.com/group/search?group=146409&cat=1013&q=静安")
t = Time.new(2013,9,12)

open(douban_url) { |f|
  content = f.read()
  links = content.scan(/<tr class=\"pl\">[\s\S]*?<\/tr>/).flatten

  links = links.select { |link| link =~ (Regexp.new t.strftime("%Y-%m-%d")) }

  links.each do |link|
    title = /title="([\s\S]*?)">[^<\d]/.match(link)
    date = /\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d/.match(link)
    print title, "  ---  ", date, "\n\n"
  end
}
