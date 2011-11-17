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
@end


@implementation NSArray (mxcl)
- (id)sortedArrayUsingDescriptor:(NSSortDescriptor *)descriptor {
    return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}
- (id)firstObject {
    return self.count > 0
            ? [self objectAtIndex:0]
            : nil;
}
- (id)shuffledArray {
    switch (self.count) {
        case 0:
        case 1:
            return self;
        case 2:
            return [NSArray arrayWithObjects:[self objectAtIndex:1], [self objectAtIndex:0], nil];
        default: {
            NSMutableArray *ll = [NSMutableArray arrayWithArray:self];
            do {
                for (int i = ll.count - 1; i > 0; --i) // Knuth-Fisher-Yates
                    [ll exchangeObjectAtIndex:rand() % (i + 1) withObjectAtIndex:i];
            } while ([ll isEqualToArray:self]); // dangerous!
            return ll;
        }
    }
}
@end


@implementation NSMutableArray (mxcl)
- (void)sortUsingDescriptor:(NSSortDescriptor *)descriptor {
    [self sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}
@end
