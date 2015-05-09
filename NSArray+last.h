#import <Foundation/NSArray.h>

@interface NSArray (YOLOLast)

/**
 Returns the last `n` elements from receiver.

    id rv = @[@1, @2, @3, @4, @5, @6].last(2);
    // rv => @[@5, @6]

 PROTIP: If there are insufficient elements in the array, YOLOKit returns
 as many as it can.
*/
- (NSArray *(^)(NSUInteger))last;

@end
