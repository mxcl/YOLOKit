#import "NSArray+mxcl.h"

@implementation NSArray (RubyEnumerable)
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

- (id)find:(BOOL (^)(id o))block {
    for (id item in self)
        if (block(item))
            return item;
    return nil;
}
@end


@implementation NSArray (mxcl)
- (id)sortedArrayUsingDescriptor:(NSSortDescriptor *)descriptor {
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}
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
@end


@implementation NSMutableArray (mxcl)

- (void)sortUsingDescriptor:(NSSortDescriptor *)descriptor {
    [self sortUsingDescriptors:@[descriptor]];
}

- (id)pop {
    if (self.count) {
        id o = [[self[0] retain] autorelease];
        [self removeObjectAtIndex:0];
        return o;
    } else {
        return nil;
    }
}

@end
