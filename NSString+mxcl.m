#import "NSString+mxcl.h"

@implementation NSString (mxcl)
- (BOOL)matches:(NSString *)pattern {
    return [self rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound;
}
@end
