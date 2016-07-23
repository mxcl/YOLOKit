#import <Foundation/NSSet.h>

@interface NSSet (YOLOGroupBy)

/**
 Groups the collection by result of the given block.

    id rv = @[@1, @2, @3, @4].groupBy(^(NSNumber *n) {
        return @(n.intValue % 2);
    });
    // rv => @{@0: @[@1, @3], @1: @[@2, @4]}
*/
- (NSDictionary *(^)(id (^)(id o)))groupBy;

@end
