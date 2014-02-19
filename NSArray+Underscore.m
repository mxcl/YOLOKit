#import "YOLO.h"
#import <objc/runtime.h>


@implementation NSArray (Underscore)

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
