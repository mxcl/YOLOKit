#import <Foundation/NSDictionary.h>

@interface NSDictionary (YOLOMap)

/**
 Invokes the given block once for each key, value pair in the receiver.
 Returns an array containing the values returned by the block.

    id rv = @{@1: @2, @2: @4, @3: @9}.map(^(id key, id obj){
        return @([key intValue] + [obj intValue]);
    }).sort;

    // rv = @[@3, @6, @12]
    // NOTE `sort` called illustratively because dictionary order is undefined.
*/
- (NSArray *(^)(id (^)(id key, id obj)))map;

@end
