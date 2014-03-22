Pod::Spec.new do |s|
  s.name         = "YOLOKit"
  s.requires_arc = true
  s.source_files = '*.m', 'YOLO.h'
  s.frameworks   = 'Foundation'
end
