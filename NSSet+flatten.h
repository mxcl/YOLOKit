#import <Foundation/NSSet.h>

@interface NSSet (YOLOFlatten)

/**
 Returns a new, one-dimensional array that is a recursive flattening of
 the receiver.

    id rv = @[@[@1, @[@2]], @3, @[@4]].flatten
    // rv => @[@1, @2, @3, @4]
*/
- (NSSet *)flatten;

@end
