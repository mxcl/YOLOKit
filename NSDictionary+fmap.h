#import <Foundation/NSDictionary.h>

@interface NSDictionary (YOLOFMap)

/**
 Invokes the given block once for each key, value pair in the receiver.
 Returns a dictionary containing the values returned by the block.

    id rv = @{@1: @2, @2: @4, @3: @9}.fmap(^(id obj){
        return @([obj intValue] * 2);
    });
    // rv = @{@1: @4, @2: @8, @3: @18}

 If the given block returns nil, that element is skipped in the returned
 dictionary.

 The given block can have up to three parameters, the first is an element
 in the dictionary, the second that element’s key, and the third the dictionary
 itself.

 @see -map
*/
- (NSDictionary *(^)(id block))fmap;

@end
