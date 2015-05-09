#import <Foundation/NSDictionary.h>

@interface NSDictionary (YOLOArray)

/**
 Returns a new array of arrays of key, value pairs.

    id rv = @{@3: @"c", @1: @"a", @4: @"d", @2: @"b"}.array
    // rv = [@[@"3", @"c"], @[@1, @"a"], @[@4, @"d"], @[@2, @"b"]]
    // NOTE array order is undefined

    rv = rv.sort.transpose[1]
    // rv = [@"a", @"b", @"c", @"d"]
    // NOTE `rv.allValues.sort` would be more efficient
*/
- (NSArray *)array;


@end
