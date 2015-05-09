#import <Foundation/NSArray.h>

@interface NSArray (YOLOShuffle)

/**
 Returns a new array that is shuffled.

 NOTE: Uses the Fisher–Yates shuffle algorithm.
*/
- (NSArray *)shuffle;

@end
