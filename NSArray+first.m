#import "NSArray+slice.h"
#import "YOLO.ph"

@implementation NSArray (YOLOFirst)

- (NSArray *(^)(NSUInteger))first {
    return ^(NSUInteger num) {
        return self.slice(0, num);
    };
}

@end
