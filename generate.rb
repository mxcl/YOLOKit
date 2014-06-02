#!/usr/bin/ruby

require 'net/http'
result = Net::HTTP.get(URI.parse('https://raw.githubusercontent.com/mxcl/YOLOKit/master/YOLO.h'))

result =~ /@interface #{ARGV[0]} \(YOLO\)(.*?)@end/m

puts "# #{ARGV[0]}"
puts

$1.gsub(%r{/\*\*(.*?)\*/\s*\n- (.*?;)}m) do
  highlight = false;
  appledoc = $1
  protipping = false

  $2 =~ /.*\)(.*);/
  puts
  puts "## <span style='color:lightgray'>#{ARGV[0]}.</span>#$1"
  puts

  appledoc.split("\n").each do |ln|
    next if ln.strip.start_with? "@see"

    if highlight
      if !ln.start_with?"    "
        highlight = false
        puts "{% endhighlight %}"
      end
    elsif ln.start_with?"    "
      highlight = true
      puts "{% highlight objectivec %}"
    elsif ln.start_with?" PROTIP:"
      print "<p class='protip'>"
      protipping = true
    elsif ln.strip.empty? and protipping
      protipping = false
      print "</p>"
    end
    puts ln
  end
  
  puts "{% endhighlight %}" if highlight
  puts "</p>" if protipping
end
