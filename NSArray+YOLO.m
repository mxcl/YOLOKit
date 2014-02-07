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

- (NSArray *(^)(id (^)(id o)))pmap {
    return ^NSArray *(id (^block)(id))
    {
        NSPointerArray *aa = [NSPointerArray new];
        aa.count = self.count;
        [self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id o = block(obj);
            [aa replacePointerAtIndex:idx withPointer:(__bridge_retained void *)o];
        }];

        [aa compact];
        NSArray *rv = aa.allObjects;

        for (int x = 0; x < aa.count; ++x)
            CFRelease([aa pointerAtIndex:x]);

        return rv;
    };
}

- (BOOL)empty {
    return self.count == 0;
}

@end
