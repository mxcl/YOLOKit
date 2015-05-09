#import "NSArray+slice.h"
#import "YOLO.ph"

@implementation NSArray (YOLOLast)

- (NSArray *(^)(NSUInteger))last {
    return ^(NSUInteger num) {
        return self.slice(self.count - num, num);
    };
}

@end
