#import <Foundation/NSSet.h>

@interface NSSet (YOLOFind)

/**
 Passes each entry in the array to the given block, returning the first
 element for which block is not `NO`. If no object matches, returns
 `nil`.

    id rv = @[@1, @2, @3, @4].find(^(id n){
        return [n isEqual:@3];
    });
    // rv => @3
*/
- (id(^)(id))find;

@end
