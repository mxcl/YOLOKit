#import "NSArray+slice.h"
#import "YOLO.ph"

@implementation NSArray (YOLOSnip)

- (NSArray *(^)(NSUInteger numberToTrim))snip {
    return ^(NSUInteger num){
        return self.slice(0, self.count - num);
    };
}

@end
