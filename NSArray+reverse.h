#import <Foundation/NSArray.h>

@interface NSArray (YOLOReverse)

/**
 Returns a new array that is the receiver, reversed.

   id rv = @[@1, @2, @3, @4].reverse;
   // rv => @[@4, @3, @2, @1]

 NOTE: Did you know about `array.reverseEnumerator.allObjects`? We don’t
 use that in fact to save allocations, but you could do that on projects
 without YOLOKit.
*/
- (NSArray *)reverse;

@end
