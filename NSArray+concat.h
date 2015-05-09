#import <Foundation/NSArray.h>

@interface NSArray (YOLOConcat)

/**
 Returns a new array that is the receiver with the given array
 concatenated to the end.

    id rv = @[@1, @2].concat(@[@3, @4]);
    // rv => @[@1, @2, @3, @4]
*/
- (NSArray *(^)(NSArray *other_array))concat;

@end
