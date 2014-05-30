@import Foundation.NSOrderedSet;
#import "YOLO.ph"

@implementation NSArray (YOLO)

- (id)uniq {
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

@end
