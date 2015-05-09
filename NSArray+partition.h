#import <Foundation/NSArray.h>

@interface NSArray (YOLOPartition)

/**
 Partitions the receiver into two arrays based on the boolean return
 value of the given block.

    id rv = @[@"A", @"B", @"AA"].partition(^(id s){
        return [s hasPrefix:@"A"];
    });
    //rv => @[@[@"A", @"AA"], @[@"B"]]
*/
- (NSArray *(^)(id blockReturningBool))partition;

@end
