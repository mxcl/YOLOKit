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
@end


@implementation NSMutableArray (mxcl)
- (void)sortUsingDescriptor:(NSSortDescriptor *)descriptor {
    [self sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}
@end
