#import <Foundation/Foundation.h>

@interface NSString (mxcl)
- (BOOL)matches:(NSString *)pattern;
- (NSNumber *)wordCount;
- (NSRange)range;
- (NSString *)strippedString;
- (NSString *)chuzzle;
@end
