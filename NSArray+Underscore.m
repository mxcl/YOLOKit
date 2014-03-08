#import "YOLO.h"
#import <objc/runtime.h>


@implementation NSArray (Underscore)

- (NSArray *(^)(id o))partition {
    return ^NSArray *(BOOL(^block)(id o)) {
        id aa = [NSMutableArray new];
        id bb = [NSMutableArray new];
        for (id o in self)
            [block(o) ? aa : bb addObject:o];
        return @[aa, bb];
    };
}

- (NSArray *(^)(NSString *))pluck {
    return ^NSArray *(NSString *key) {
        if (!key.length)
            return self;

        return [self valueForKeyPath:key];
    };
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
