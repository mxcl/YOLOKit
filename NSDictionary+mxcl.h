#import <Foundation/Foundation.h>

@interface NSDictionary (mxcl)

// returns nil if not a string or if string length is zero after trimming whitespace from both ends
- (NSString *)massagedStringForKey:(id)key;

- (NSData *)JSONData;
- (NSString *)JSONString;

@end
