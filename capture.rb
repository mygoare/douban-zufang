# encoding: utf-8

require "open-uri"
require "uri"

douban_url = URI.escape("http://www.douban.com/group/search?group=146409&cat=1013&q=静安")
t = Time.now()

open(douban_url) { |f|
  content = f.read()
  links = content.scan(/<tr class=\"pl\">[\s\S]*?<\/tr>/).flatten

  links = links.select { |link| link =~ (Regexp.new t.strftime("%Y-%m-%d")) }

  if links.empty?
    puts "今天没有相关房源更新！"
    break;
  end

  links.each do |link|
    href = /<a class="" href="(.*)" title="(.*)">/.match(link)[1]
    title = /<a class="" href="(.*)" title="(.*)">/.match(link)[2]
    date = /\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/.match(link)
    print href, "  -  ", title, "  -  ", date, "\n\n"
  end
}
