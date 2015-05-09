#import <Foundation/NSArray.h>

@interface NSArray (YOLOInject)

/**
 Combines all elements of the receiver by applying a binary operation.

    id rv = @[@1, @2, @3, @4].inject(@{}, ^(NSMutableDictionary *memo, NSNumber *n){
        memo[n] = @(n.intValue * n.intValue);
        return memo;
    });
    // rv => @{@1: @1, @2: @4, @3: @9, @4: @16}

 PROTIP: If you feed `inject` a non-mutable dictionary or array YOLOKit
 mutates it for your block, and then finally returns a non-mutable copy.

 @see -reject
*/
- (id(^)(id initial_memo, id (^)(id memo, id obj)))inject;

@end
