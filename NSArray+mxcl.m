#import "NSArray+mxcl.h"

@implementation NSArray (RubyEnumerable)
- (NSArray *)map:(id (^)(id obj))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    for (id item in self) {
        id o = block(item);
        if (o)
            [array addObject:o];
    }
    return array;
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
