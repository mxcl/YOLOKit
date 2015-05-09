#import <Foundation/NSArray.h>

@interface NSArray (YOLOIndexOf)

/**
 Returns the index of the given object in the receiver or `NSNotFound` if
 the object was not found.

    uint rv = @[@1, @2, @3, @4].indexOf(@2);
    // rv => 1

 PROTIP: `NSNotFound` has the value `NSIntegerMax` so you don’t need to
 directly check for it, you can instead check if the returned value is
 less than the count of the receiver.
*/
- (NSUInteger (^)(id obj))indexOf;

@end
