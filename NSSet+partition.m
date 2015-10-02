#import "YOLO.ph"

@implementation NSSet (YOLOPartition)

- (NSSet *(^)(id o))partition {
    return ^NSSet *(BOOL(^block)(id o)) {
        id aa = [NSMutableSet new];
        id bb = [NSMutableSet new];
        for (id o in self)
            [block(o) ? aa : bb addObject:o];
        return [NSSet setWithArray:@[aa, bb]];
    };
}

@end
