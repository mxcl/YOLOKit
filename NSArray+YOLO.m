#import "YOLO.h"


@implementation NSArray (YOLO)

- (NSSet *)set {
    return [NSSet setWithArray:self];
}

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
