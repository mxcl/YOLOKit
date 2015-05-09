#import <Foundation/NSValue.h>

@interface NSNumber (YOLOUpTo)

/**
 Returns an array of consequentive numbers from receiver up to (and
 including) the given number.

    id rv = @1.upTo(6);
    // rv => @[@1, @2, @3, @4, @5, @6]
*/
- (NSArray *(^)(NSInteger))upTo;

@end
