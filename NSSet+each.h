#import <Foundation/NSSet.h>

@interface NSSet (YOLOEach)

/**
 @see NSArray’s -each
*/
- (NSSet *(^)(void (^)(id o)))each;

@end
