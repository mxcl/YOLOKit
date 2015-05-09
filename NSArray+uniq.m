@import Foundation.NSOrderedSet;
#import "YOLO.ph"

@implementation NSArray (YOLOUniq)

- (id)uniq {
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

@end
