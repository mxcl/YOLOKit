#import <Foundation/NSArray.h>

@interface NSMutableArray (YOLOPop)

/**
 Treats receiver like a stack and removes the last object, returning it.

    NSMutableArray *aa = [NSMutableArray new];
    id rv = aa.push(@1).push(@2).push(@3).pop()
    // rv => @3

 @see -push
*/
- (id)pop;

@end
