#import "YOLO.h"


@implementation NSArray (YOLO)

- (id)shuffledArray {
    switch (self.count) {
        case 0:
        case 1:
            return self;
        case 2:
            return @[self[1], self[0]];
        default: {
            NSMutableArray *ll = [NSMutableArray arrayWithArray:self];
            do {
                for (NSUInteger i = ll.count - 1; i; --i) // Knuth-Fisher-Yates
                    [ll exchangeObjectAtIndex:rand() % (i + 1) withObjectAtIndex:i];
            } while ([ll isEqualToArray:self]); // dangerous!
            return ll;
        }
    }
}

- (id)JSONData {
    return [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
}

- (id)JSONString {
    return [[NSString alloc] initWithData:[self JSONData] encoding:NSUTF8StringEncoding];
}

- (NSSet *)set {
    return [NSSet setWithArray:self];
}

- (NSArray *(^)(void (^)(id)))without {
    return ^(id arrayOrSet) {
        id objs = [arrayOrSet isKindOfClass:[NSSet class]] ? [arrayOrSet allObjects] : arrayOrSet;
        id rv = self.mutableCopy;
        [rv removeObjectsInArray:objs];
        return rv;
    };
}

@end



@implementation NSArray (PListCompliant)

- (id)plistCompliantObject {
    NSMutableArray *array = [NSMutableArray new];
    for (id obj in self) {
        if ([obj respondsToSelector:@selector(plistCompliantObject)])
            [array addObject:[obj plistCompliantObject]];
        else if (obj != [NSNull null])
            [array addObject:obj];
    }
    return [NSArray arrayWithArray:array];
}

@end
