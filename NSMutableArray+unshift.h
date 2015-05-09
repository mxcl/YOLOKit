#import <Foundation/NSArray.h>

@interface NSMutableArray (YOLOUnshift)

/**
 Inserts the given object at the front of receiver, moving all other
 objects in the receiver up one index.

    NSMutableArray *aa = [NSMutableArray new];
    id rv = aa.unshift(@1).unshift(@2).unshift(@3);
    // rv => @[@3, @2, @1]

 @see -shift
*/
- (NSMutableArray *(^)(id obj))unshift;

@end
