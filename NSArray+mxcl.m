#import "NSArray+mxcl.h"


@implementation NSArray (RubyEnumerable)

- (id)inject:(id (^)(id memo, id obj))block {
    return [self inject:nil block:block];
}

- (id)inject:(id)memo block:(id (^)(id memo, id obj))block {
    for (id obj in self)
        memo = block(memo, obj);
    return memo;
}

- (NSArray *)map:(id (^)(id obj))block {
    id objs[self.count];
    int ii = 0;
    for (id item in self) {
        id o = block(item);
        if (o)
            objs[ii++] = o;
    }
    return [NSArray arrayWithObjects:objs count:ii];
}

- (id)select:(BOOL (^)(id o))block {
    id objs[self.count];
    int ii = 0;
    for (id item in self) {
        if (block(item))
            objs[ii++] = item;
    }
    return [NSArray arrayWithObjects:objs count:ii];
}

- (id)reject:(BOOL (^)(id o))block {
    return [self select:^BOOL(id o) {
        return !block(o);
    }];
}

- (id)find:(BOOL (^)(id o))block {
    for (id item in self)
        if (block(item))
            return item;
    return nil;
}

- (id)flatten {
    NSMutableArray *aa = [NSMutableArray array];
    for (id o in self) {
        if ([o isKindOfClass:[NSArray class]])
            [aa addObjectsFromArray:[o flatten]];
        else
            [aa addObject:o];
    }
    return aa;
}

@end


@implementation NSArray (mxcl)
- (id)firstObject {
    return self.count > 0
            ? self[0]
            : nil;
}
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

- (id)uniq {
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

@end


@implementation NSMutableArray (mxcl)

- (id)pop {
    if (self.count) {
        id o = self[0];
        [self removeObjectAtIndex:0];
        return o;
    } else {
        return nil;
    }
}

@end
