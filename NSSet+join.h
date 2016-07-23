#import <Foundation/NSSet.h>

@interface NSSet (YOLOJoin)

/**
 Returns a string of all the receiver’s elements joined with the provided
 separator string.

    id rv = @[@1, @2, @3, @4].join(@",");
    // rv => @"1,2,3,4"

    id rv = @[@1, @2, @3, @4].join(@"");
    // rv => @"1234"

 PROTIP: `-description` is called on all objects before joining them.
*/
- (NSString *(^)(NSString *))join;

@end
