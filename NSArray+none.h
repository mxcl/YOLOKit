#import <Foundation/NSArray.h>

@interface NSArray (YOLONone)

/**
    BOOL rv = @[@1, @2, @3].none(^(id o){
        return [o intValue] > 4;
    });
    // rv => YES

 Instead of a block, you can pass a `Class` object.

    BOOL rv = @[@1, @2, @3].none(NSNumber.class);
    // rv => NO
*/
- (BOOL(^)(id blockOrClass))none;

@end
