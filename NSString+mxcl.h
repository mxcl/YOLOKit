#import <Foundation/Foundation.h>

@interface NSString (mxcl)
- (BOOL)matches:(NSString *)pattern;
- (NSNumber *)wordCount;
- (NSRange)range;
@end
