#import <Foundation/NSDictionary.h>

@interface NSDictionary (YOLOWithout)

/**
 Returns a new dictionary where values for objects in the given array/set/object 
 are removed from the receiver.

    id rv = @{@1:@"1", @2:@"2", @3:@"3", @4:@"4", @5:@"5", @6:@"6"].without(@2);
    // rv => @[@1:@"1", @3:@"3", @4:@"4", @5:@"5", @6:@"6"]

    id rv = @[@1:@"1", @2:@"2", @3:@"3", @4:@"4", @5:@"5", @6:@"6"].without(@[@2, @3]);
    // rv => @[@1:@"1", @4:@"4", @5:@"5", @6:@"6"]
*/
- (NSDictionary *(^)(id arrayOrSetOrObject))without;

@end
