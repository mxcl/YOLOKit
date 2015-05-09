#import <Foundation/NSArray.h>

@interface NSArray (YOLOMin)

/**
 Returns the element for which the given block returns the smallest
 integer.

    id rv = @[@4, @2, @1, @3].min(^(NSNumber *n){
        return n;
    });
    // rv => @1

 NOTE: currently you must return an integer, we plan to allow you to
 return whatever you like.
*/
- (id(^)(id))min;

@end
