#import "YOLO.h"


@implementation NSMutableArray (YOLO)

- (id)pop {
    if (self.count) {
        id o = self[0];
        [self removeObjectAtIndex:0];
        return o;
    } else {
        return nil;
    }
}

@end
