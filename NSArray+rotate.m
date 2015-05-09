#import "NSArray+concat.h"
#import "NSArray+skip.h"
#import "NSArray+snip.h"
#import "YOLO.ph"

@implementation NSArray (YOLORotate)

- (NSArray *(^)(NSInteger))rotate {
    return ^(NSInteger pivot) {
        if (pivot < 0)
            pivot = (int)self.count + pivot;
        return self.skip(pivot).concat(self.snip(pivot));
    };
}

@end
