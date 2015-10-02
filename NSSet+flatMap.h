#import <Foundation/NSSet.h>

@interface NSSet (YOLOFlatMap)

/**
 Returns a new set with the concatenated results of running block once
 for every element in the receiver.

    id rv = @[@1, @2, @3, @4].flatMap(^(id n){
        return @[n, n];
    });
    // rv => @[@1, @1, @2, @2, @3, @3, @4, @4]

    id rv = @[@1, @2, @3, @4].flatMap(^(id n){
        return [NSSet setWithArray:@[n, n]];
    });
    // rv => @[@1, @1, @2, @2, @3, @3, @4, @4]
 
    id rv = @[@1, @2, @3, @4].flatMap(^(id n){
        return @[n, @[n]];
    });
    // rv => @[@1, @[@1], @2, @[@2], @3, @[@3], @4, @[@4]]

 PROTIP: Useful over vanilla map followed by a flatten because flatten is
 recursive, and you may want to preserve array relationships beyond the
 first level. Also, `flatMap` is technically more efficient.
*/
- (id(^)(NSSet *(^)(id o)))flatMap;

@end
