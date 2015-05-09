#import <Foundation/NSDictionary.h>

@interface NSDictionary (YOLOExtend)

/**
 Returns a new, merged dictionary.

 @param higherPriorityDictionary The dictionary to merge with the
 receiver. If any keys conflict, the values in this dictionary take precendence.

    id rv = @{@1: @1, @2: @4}.extend(@{@1: @9, @10: @100});
    // rv => @{@1: @9, @2: @4, @10: @100}
*/
- (NSDictionary *(^)(NSDictionary *higherPriorityDictionary))extend;

@end
