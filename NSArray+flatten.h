#import <Foundation/NSArray.h>

@interface NSArray (YOLOFlatten)

/**
 Returns a new, one-dimensional array that is a recursive flattening of
 the receiver.

    id rv = @[@[@1, @[@2]], @3, @[@4]].flatten
    // rv => @[@1, @2, @3, @4]
*/
- (NSArray *)flatten;

@end
