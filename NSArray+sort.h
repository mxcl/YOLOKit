#import <Foundation/NSArray.h>

@interface NSArray (YOLOSort)

/**
 Returns the receiver, sorted.

    id rv = @[@2, @1, @3, @5, @4].sort;
    // rv => @[@1, @2, @3, @4, @5]

 We even try to handle mixed object types:

    id rv = @[@"20", @"1", @3, @5, @"4"].sort;
    // rv => @[@"1", @3, @"4", @5, @"20"]

 @see -sortBy

 PROTIP: Internally `sort` attempts to sort all objects using `-compare:`
 but if that fails, it calls `-description` on all objects and uses
 `-sortBy`.
*/
- (NSArray *)sort;

/**
 Sorts all objects using the return value of the given block as the
 sorting criteria.

    MKShape *rhombas = [MKShape new]; rhombas.title = @"rhombas";
    MKShape *ellipse = [MKShape new]; ellipse.title = @"ellipse";
    MKShape *hexagon = [MKShape new]; hexagon.title = @"hexagon";

    id rv = @[rhombas, ellipse, hexagon].sortBy(^(id shape){
        return [shape title];
    });
    // rv => @[ellipse, hexagon, rhombas]

    id rv = @[rhombas, ellipse, hexagon].sortBy(@"title")
    // rv => @[ellipse, hexagon, rhombas]

    id rv = @[
        @{@"name": @"frank", @"age": @32},
        @{@"name": @"frank", @"age": @31},
        @{@"name": @"bob", @"age": @54},
        @{@"name": @"zane", @"age": @1},
        @{@"name": @"frank", @"age": @12}
    ].sortBy(^(id o){
        return @[o[@"name"], o[@"age"]];
    });
    // rv => @[
    //     @{@"name": @"bob", @"age": @54},
    //     @{@"name": @"frank", @"age": @12},
    //     @{@"name": @"frank", @"age": @31},
    //     @{@"name": @"frank", @"age": @32},
    //     @{@"name": @"zane", @"age": @1}
    // ];

 PROTIP: You will need you to implement a compare: method for any custom
 objects you return.

 PROTIP: Returning an array from your block will sort the receiver so
 that the first object is the first sorting criteria, and the second
 object is the second sorting criteria, et cetera.
*/
- (NSArray *(^)(id blockOrKey))sortBy;

@end
