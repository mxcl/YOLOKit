#import "YOLO.h"
#import <objc/runtime.h>

@implementation NSArray (Underscore)

- (NSArray *(^)(id ))pluck {
    return ^NSArray *(id key) {
        if ([key isKindOfClass:[NSString class]])
            return [self valueForKeyPath:key];

        if (class_isMetaClass(object_getClass(key)))
            return self.select(^(id o){
                return [o isKindOfClass:key];
            });

        return @[];
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
