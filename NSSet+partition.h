#import <Foundation/NSSet.h>

@interface NSSet (YOLOPartition)

/**
 Partitions the receiver into two sets based on the boolean return
 value of the given block.

    id rv = @[@"A", @"B", @"AA"].partition(^(id s){
        return [s hasPrefix:@"A"];
    });
    //rv => @[@[@"A", @"AA"], @[@"B"]]
*/
- (NSSet *(^)(id blockReturningBool))partition;

@end
