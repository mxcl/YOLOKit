#import <Foundation/NSArray.h>

@interface NSMutableArray (YOLOShift)

/**
 Removes the receiver’s first object and returns it.

    NSMutableArray *aa = [NSMutableArray new];
    id rv = aa.unshift(@1).unshift(@2).unshift(@3).shift();
    // rv => @3

 @see -unshift
*/
- (id)shift;

@end
