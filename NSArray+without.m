#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(id))without {
    return ^NSArray *(id arrayOrSet) {
        if (!arrayOrSet)
            return self;

        id objs = [arrayOrSet isKindOfClass:[NSSet class]]
                ? [arrayOrSet allObjects]
                : [arrayOrSet isKindOfClass:[NSArray class]]
                ? arrayOrSet
                : @[arrayOrSet];
        id rv = self.mutableCopy;
        [rv removeObjectsInArray:objs];
        return rv;
    };
}

@end
