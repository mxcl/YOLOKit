#import <Foundation/NSArray.h>

@interface NSArray (YOLOFirst)

/**
 Returns the first `n` elements of the receiver.

    id rv = @[@1, @2, @3, @4, @5, @6].first(2);
    // rv => @[@1, @2]

 PROTIP: YOLOKit is forgiving; if the array doesn’t have enough elements,
 `first` returns as many as it can.
*/
- (NSArray *(^)(NSUInteger))first;

@end
