#import <Foundation/NSArray.h>

@interface NSMutableArray (YOLOPush)

/**
 Treats receiver like a stack and adds the given object to the end of the
 receiver.

    NSMutableArray *aa = [NSMutableArray new];
    id rv = aa.push(@1).push(@2).push(@3)
    // rv => @[@1, @2, @3]

 @see -pop
*/
- (NSMutableArray *(^)(id obj))push;

@end
