#import "YOLO.h"


@implementation NSArray (YOLO)

- (NSSet *)set {
    return [NSSet setWithArray:self];
}

- (NSArray *(^)(NSUInteger))chunk {
    return ^(NSUInteger size){
        id aa = [NSMutableArray new];
        const NSUInteger n = self.count / size;
        for (int x = 0; x < n; ++x)
            [aa addObject:self.slice(x*size, size)];
        return aa;
    };
}

- (NSDictionary *)dict {
    NSArray *aa = self.transpose;
    if (aa.count <= 1)
        return @{};
    return [NSDictionary dictionaryWithObjects:aa[1] forKeys:aa[0]];
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

- (BOOL (^)(id o))has {
    return ^BOOL(id o){
        return [self containsObject:o];
    };
}

- (NSArray *(^)(NSUInteger numberToTrim))snip {
    return ^(NSUInteger num){
        return self.slice(0, self.count - num);
    };
}

- (NSArray *(^)(NSUInteger numberToTrim))skip {
    return ^(NSUInteger num){
        return self.last(self.count - num);
    };
}

@end
