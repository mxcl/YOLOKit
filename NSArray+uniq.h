#import <Foundation/NSArray.h>

@interface NSArray (YOLOUniq)

/**
 Returns a new array by removing duplicate values in the receiver.

    id rv = @[@1, @1, @2].uniq;
    // rv => @[@1, @2]

 PROTIP: Order is preserved.

 PROTIP: Equality is determined via `-hash` and `-isEqual:`.
*/
- (NSArray *)uniq;

@end
