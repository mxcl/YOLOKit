#import <Foundation/NSSet.h>

@interface NSSet (YOLOFMap)

/**
 @see NSArray's -fmap
*/
- (NSSet *(^)(id (^)(id obj)))fmap;

@end
