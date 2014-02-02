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

- (NSMutableArray *(^)(id))add {
    return ^(id o){
        [self addObject:o];
        return self;
    };
}

- (NSArray *(^)(NSUInteger))take {
    return ^(NSUInteger number) {
        NSRange rng = NSMakeRange(0, number);
        id rv = [self subarrayWithRange:rng];
        [self removeObjectsInRange:rng];
        return rv;
    };
}

@end
