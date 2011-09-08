#import "NSString+mxcl.h"

@implementation NSString (mxcl)
- (BOOL)matches:(NSString *)pattern {
    return [self rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound;
}

- (NSNumber *)wordCount {
    __block int count = 0;
    [self enumerateSubstringsInRange:range
                               options:NSStringEnumerationByWords
                            usingBlock:^(NSString *word,
                                         NSRange wordRange,
                                         NSRange enclosingRange,
                                         BOOL *stop)
        {
            count++;
        }
    ];
    return [NSNumber numberWithInt:count];
}
@end
