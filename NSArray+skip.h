#import <Foundation/NSArray.h>

@interface NSArray (YOLOSkip)

/**
 Skips the first `n` elements and returns the rest of the array.

    id rv = @[@1, @2, @3, @4, @5, @6].skip(2);
    // rv => @[@3, @4, @5, @6]

 @see -first
 @see -last
 @see -slice
 @see -snip
*/
- (NSArray *(^)(NSUInteger numberToSkip))skip;

@end
