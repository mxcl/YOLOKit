#import <Foundation/NSArray.h>

@interface NSArray (YOLOPMap)

/**
 Map, but run in parallel. Obviously: be thread safe in your block. The
 call waits for all elements to be processed. Typically not worth using
 unless you have large arrays since the overhead of
 thread-synchronization may be greater than the parallel savings
 otherwise.

 @see -map
*/
- (NSArray *(^)(id (^)(id o)))pmap;

@end
