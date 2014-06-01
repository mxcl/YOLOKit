#!/usr/bin/ruby

require 'net/http'
result = Net::HTTP.get(URI.parse('https://raw.githubusercontent.com/mxcl/YOLOKit/master/YOLO.h'))

result =~ /@interface #{ARGV[0]} \(YOLO\)(.*?)@end/m

puts "# #{ARGV[0]}"
puts

$1.gsub(%r{/\*\*(.*?)\*/\n- (.*?;)}m) do
  highlight = false;
  appledoc = $1

  $2 =~ /.*\)(.*);/
  puts
  puts "## #{ARGV[0]}.#$1"
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
    end
    puts ln.strip
  end
  
  puts "{% endhighlight %}" if highlight
end
