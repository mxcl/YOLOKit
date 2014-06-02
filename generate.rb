#!/usr/bin/ruby

require 'net/http'
result = Net::HTTP.get(URI.parse('https://raw.githubusercontent.com/mxcl/YOLOKit/master/YOLO.h'))

result =~ /@interface #{ARGV[0]} \(YOLO\)(.*?)@end/m

$1.gsub(%r{/\*\*(.*?)\*/\s*\n- (.*?;)}m) do
  highlight = false;
  appledoc = $1
  protipping = false

  $2 =~ /.*\)(.*);/
  puts
  puts "### <span style='color:lightgray'>#{ARGV[0]}.</span>#$1"
  puts

  appledoc.split("\n").each do |ln|
    next if ln.strip.start_with? "@see"

    if ln.start_with?"    " and not highlight
      highlight = true
      puts "{% highlight objectivec %}"
    elsif ln.start_with?" PROTIP:"
      if highlight
        highlight = false
        puts "{% endhighlight %}"
        puts
      end
      print "<p class='protip'><b>PROTIP</b>"
      ln = ln[8..-1]
      protipping = true
    elsif ln.strip.empty? and protipping
      protipping = false
      print "</p>"
    elsif highlight and not ln.strip.empty? and not ln.start_with?"    "
      highlight = false
      puts "{% endhighlight %}"
      puts
    end

    if highlight
      puts ln.sub(/^    /, "")
    else
      puts ln
    end
  end
  
  puts "{% endhighlight %}" if highlight
  puts "</p>" if protipping
end
