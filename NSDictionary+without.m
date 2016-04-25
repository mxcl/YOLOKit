#import "YOLO.ph"

@implementation NSDictionary (YOLOWithout)

- (NSDictionary *(^)(id))without {
    return ^NSDictionary *(id arrayOrSetOrObject) {
        if (!arrayOrSetOrObject)
            return self;

        id objs = [arrayOrSetOrObject isKindOfClass:[NSSet class]]
                ? [arrayOrSetOrObject allObjects]
                : [arrayOrSetOrObject isKindOfClass:[NSArray class]]
                ? arrayOrSetOrObject
                : @[arrayOrSetOrObject];
        id rv = self.mutableCopy;
        [rv removeObjectsForKeys:objs];
        return rv;
    };
}

@end
