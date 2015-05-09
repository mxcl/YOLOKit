#import <Foundation/NSArray.h>

@interface NSArray (YOLOMax)

/**
 Returns the element for which the given block returns the largest
 integer.

    id rv = @[@4, @2, @1, @3].max(^(NSNumber *n){
        return n.intValue;
    });
    // rv => @4

    id rv = @[@4, @2, @1, @3].max(^(NSNumber *n){
        return (n.intValue - 3) * (n.intValue - 3);
    });
    // rv => @1

 NOTE: currently you must return an integer, we plan to allow you to
 return whatever you like.
*/
- (id(^)(id))max;

@end
