#import "YOLO.ph"

@implementation NSSet (YOLOWithout)

- (NSSet *(^)(id))without {
    return ^NSSet *(id arrayOrSetOrObject) {
        if (!arrayOrSetOrObject)
            return self;

        id objs = [arrayOrSetOrObject isKindOfClass:[NSSet class]]
                ? [arrayOrSetOrObject allObjects]
                : [arrayOrSetOrObject isKindOfClass:[NSArray class]]
                ? arrayOrSetOrObject
                : @[arrayOrSetOrObject];
        id rv = self.mutableCopy;
        [rv removeObjectsInArray:objs];
        return rv;
    };
}

@end
