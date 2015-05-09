#import <Foundation/NSArray.h>

@interface NSArray (YOLOSnip)
/**
 Snips the end off the array. Returns the receiver *without* the last `n`
 elements.

    id rv = @[@1, @2, @3, @4, @5, @6].snip(2);
    // rv => @[@1, @2, @3, @4]

 @see -first
 @see -last
 @see -skip
 @see -slice
*/
- (NSArray *(^)(NSUInteger numberToTrim))snip;

@end
