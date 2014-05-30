@import Foundation.NSOrderedSet;
#import "YOLO.h"

@implementation NSArray (YOLO)

- (id)uniq {
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

@end
