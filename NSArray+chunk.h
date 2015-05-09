#import <Foundation/NSArray.h>

@interface NSArray (YOLOChunk)

/**
 Chunks the receiver into a new array of chunk-size arrays.

    id rv = @[@1, @2, @3, @4].chunk(2)
    // rv => @[@[@1, @2], @[@3, @4]]
*/
- (NSArray *(^)(NSUInteger))chunk;

@end
