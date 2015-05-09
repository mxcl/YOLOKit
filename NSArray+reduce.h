#import <Foundation/NSArray.h>

@interface NSArray (YOLOReduce)

/**
 Reduces the receiver to a single value.

 The usual example of reduce is to sum all values in an array.

    id rv = @[@1, @2, @3, @4].reduce(^(NSNumber *memo, NSNumber *obj){
        return @(memo.intValue + obj.intValue);
    });
    // rv => @10

 Generally `-inject` is more useful. Though, when appropriate, `reduce`
 is more elegant.

    // find the longest word
    id longest = @[@"cat", @"sheep", @"bear"].reduce(^(NSString *memo, NSString *word){
        return memo.length > word.length ? memo : word;
    });
    // longest => @"sheep"

 @param memo initialized to the first value in receiver, but on subsequent iterations is the value returned from the given block.
 @param obj the value for each element in the receiver, though never the first object.

 @see -inject
*/
- (id(^)(id (^)(id memo, id obj)))reduce;

@end
