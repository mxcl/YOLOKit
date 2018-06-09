Pod::Spec.new do |s|
  s.name         = 'YOLOKit'
  s.version      = '11.2.1'
  s.source       = { :git => 'https://github.com/mxcl/YOLOKit.git', :tag => s.version }
  s.requires_arc = true
  s.summary      = 'A delightful library for enumerating Foundation objects.'
  s.homepage     = 'https://github.com/mxcl/YOLOKit'
  s.author       = { 'Max Howell' => 'mxcl@me.com' }
  s.license      = { :type => 'Public Domain' }

  s.subspec 'base' do |ss|
    ss.public_header_files = 'YOLO.h'
    ss.source_files = 'YOLO.m', 'YOLO.h'
    ss.preserve_paths = 'YOLO.ph'
  end

  %w{all any array chunk concat dict each extend find first flatMap flatten fmap get
    groupBy has indexOf inject join last map max min none partition pick pluck
    pmap pop push reduce reverse rotate sample select shift shuffle skip slice
    snip sort split transpose uniq unshift upTo without
  }.each do |subspec|
    s.subspec(subspec) do |ss|

      # adding this warning fails `pod spec lint`
      # ss.compiler_flags = '-Wno-incomplete-implementation'

      ss.dependency 'YOLOKit/base'
      ss.source_files = "*+#{subspec}.{m,h}"

      case subspec
      when 'chunk', 'first', 'last', 'snip'
        ss.dependency 'YOLOKit/slice'
      when 'dict'
        ss.dependency 'YOLOKit/transpose'
      when 'fmap'
        ss.dependency 'YOLOKit/map'
      when 'join'
        ss.dependency 'YOLOKit/pluck'
      when 'reduce'
        ss.dependency 'YOLOKit/last'
      when 'rotate'
        ss.dependency 'YOLOKit/concat'
        ss.dependency 'YOLOKit/skip'
        ss.dependency 'YOLOKit/snip'
      when 'skip'
        ss.dependency 'YOLOKit/last'
      when 'sort'
        ss.dependency 'YOLOKit/all'
        ss.dependency 'YOLOKit/transpose'
      when 'transpose'
        ss.dependency 'YOLOKit/select'
        ss.dependency 'YOLOKit/max'
        ss.dependency 'YOLOKit/each'
      end
    end
  end

end
