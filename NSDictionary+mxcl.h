#import <Foundation/Foundation.h>

@interface NSDictionary (mxcl)

// returns nil if not a string or if string length is zero after trimming whitespace from both ends
- (id)massagedStringForKey:(id)key;

@end
