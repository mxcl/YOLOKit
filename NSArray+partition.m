#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(id o))partition {
    return ^NSArray *(BOOL(^block)(id o)) {
        id aa = [NSMutableArray new];
        id bb = [NSMutableArray new];
        for (id o in self)
            [block(o) ? aa : bb addObject:o];
        return @[aa, bb];
    };
}

@end
