#import <Foundation/NSArray.h>

@interface NSArray (YOLOTranspose)

/**
 Assumes that the receiver is an array of arrays and transposes the rows
 and columns.

    id rv = @[@[@1, @2, @3], @[@4, @5, @6]].transpose;
    // rv => @[@[@1, @4], @[@2, @5], @[@3, @6]]

 PROTIP: `transpose` is surprisingly useful, if you think laterally about
 your problem.
*/
- (NSArray *)transpose;

@end
