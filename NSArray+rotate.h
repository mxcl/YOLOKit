#import <Foundation/NSArray.h>

@interface NSArray (YOLORotate)

/**
 Returns a new array rotated about the provided index.

    id rv = @[@1, @2, @3, @4, @5, @6].rotate(2);
    // rv => @[@3, @4, @5, @6, @1, @2]

    id rv = @[@1, @2, @3, @4, @5, @6].rotate(-2);
    // rv => @[@5, @6, @1, @2, @3, @4] 
*/
- (NSArray *(^)(NSInteger))rotate;

@end
