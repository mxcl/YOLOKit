#import <Foundation/NSArray.h>

@interface NSArray (YOLODict)

/**
 Convert an array of key/value pairs into the logical dictionary.

    id rv = @[@[@1, @2], @[@3, @4]].dict
    // rv => @{@1: @2, @3: @4}

    id rv = @[@1, @2, @3, @4].chunk(2).dict
    // rv => @{@1: @2, @3: @4}

 If you have a flat array you can call `chunk(2)` before `dict`. It was
 decided not to allow flat arrays to be immediately converted as it can
 lead to bugs when your array is not in the shape you expect, and those
 sorts of errors occur more commonly with tools like YOLOKit since we
 allow easy array flattening.
*/
- (NSDictionary *)dict;

@end
