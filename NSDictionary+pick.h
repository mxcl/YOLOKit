#import <Foundation/NSDictionary.h>

@interface NSDictionary (YOLOPick)

/**
 Returns a new dictionary consisting of the given keys.
*/
- (NSDictionary *(^)(id o, ...))pick;

@end
