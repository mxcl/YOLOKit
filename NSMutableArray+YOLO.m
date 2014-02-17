#import "YOLO.h"


@implementation NSMutableArray (YOLO)

- (id)popFromEnd {
    if (self.count) {
        NSUInteger x = self.count-1;
        id o = self[x];
        [self removeObjectAtIndex:x];
        return o;
    } else {
        return nil;
    }
}

- (NSMutableArray *(^)(id))append {
    return ^(id o){
        [self addObject:o];
        return self;
    };
}

- (id)popFromStart {
    if (self.count == 0)
        return nil;
    id o = self.firstObject;
    [self removeObjectAtIndex:0];
    return o;
}

- (NSMutableArray *(^)(id o))prepend {
    return ^(id o){
        [self insertObject:o atIndex:0];
        return self;
    };
}

@end
