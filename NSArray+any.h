#import <Foundation/NSArray.h>

@interface NSArray (YOLOAny)

/**
    BOOL rv = @[@1, @2, @3].any(^(id o){
        return [o intValue] == 3;
    });
    // rv => YES

 Instead of a block, you can pass a `Class` object.

    BOOL rv = @[@1, @2, @3].any(NSNumber.class);
    // rv => YES
*/
- (BOOL(^)(id blockOrClass))any;

@end
