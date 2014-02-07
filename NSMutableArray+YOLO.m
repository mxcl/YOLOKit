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

- (id)shift {
    if (self.count == 0)
        return nil;
    id o = self.firstObject;
    [self removeObjectAtIndex:0];
    return o;
}

@end
