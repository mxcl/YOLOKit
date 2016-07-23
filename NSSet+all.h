#import <Foundation/NSSet.h>


@interface NSSet (YOLOAll)

/**
 Invokes the given block for each element in the receiver. Should the
 block return `NO`, the method immediately returns `NO`, ceasing
 enumeration. If all executions of the block return `YES`, `all`
 returns `YES`.

    BOOL rv = @[@1, @2, @3].all(^(id o){
        return [o intValue] > 0;
    });
    // rv => YES

    BOOL rv = @[@1, @2, @3].all(^(int d){
        return d < 3;
    });
    // rv => NO

 Instead of a block, you can pass a `Class` object.

    BOOL rv = @[@1, @2, @3].all(NSNumber.class);
    // rv => YES
*/
- (BOOL(^)(id blockOrClass))all;

@end
