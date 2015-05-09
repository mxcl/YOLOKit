#import <Foundation/NSDictionary.h>

@interface NSDictionary (YOLOGet)

/**
 Returns the value associated with a given key.

    id rv = @{@1: @1, @2: @4}.get(@2);
    // rv => @4

 @see -objectForKey:
*/   
- (id (^)(id))get;

@end