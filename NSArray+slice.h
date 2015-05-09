#import <Foundation/NSArray.h>

@interface NSArray (YOLOSlice)

/**
 Returns a subarray consisting of the given number of elements from the
 given starting index.

    id rv = @[@1, @2, @3, @4, @5, @6].slice(2, 2));
    // rv => @[@3, @4]

 PROTIP: Use slice instead of `first`, `last`, `skip` and `snip`… when
 you must. If you find yourself writing `array.slice(0, 4)` then consider
 `array.first(4)` instead: it’s more expressive, more explicit and
 shorter to boot.

 @see -first
 @see -last
 @see -skip
 @see -snip
*/
- (NSArray *(^)(NSUInteger start, NSUInteger length))slice;

@end
