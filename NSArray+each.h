#import <Foundation/NSArray.h>

@interface NSArray (YOLOEach)

/**
 Calls the given block once for each element in the receiver, passing
 that element as the parameter.

    @[@1, @2, @3, @4].each(^(id n){
        NSLog(@"%@", n);
    });
    // => 1\n2\n3\n4\n

 `each` also supports two and three parameter versions:

    @[@4, @3, @2, @1].each(^(id n, int ii){
        NSLog(@"%d:%@", ii, n);
    });
    // => 0:1\n1:2\n2:3\n3:4\n

    @[@4, @3, @2, @1].each(^(id n, int ii, NSArray *array){
        //…
    });

    @[@4, @3, @2, @1].each(^(id n, NSNumber *index, NSArray *array){
        // and automagical conversion between int and NSNumber
    });
*/
- (NSArray *(^)(id block))each;

@end
