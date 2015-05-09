#import "NSArray+last.h"
#import "YOLO.ph"

@implementation NSArray (YOLOSkip)

- (NSArray *(^)(NSUInteger numberToTrim))skip {
    return ^(NSUInteger num){
        return self.last(self.count - num);
    };
}

@end
